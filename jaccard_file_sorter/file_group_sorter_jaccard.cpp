#include <iostream>
#include <filesystem>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <functional>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <thread>
#include <mutex>
#include <iomanip>
#include <spdlog/spdlog.h>  // Include spdlog header
#include <spdlog/sinks/basic_file_sink.h>  // Include file sink header

// 在main函数或程序初始化部分
void setup_logger(const std::string& output_filename)
{
    try
    {
        // Extract the directory from the output_filename
        std::filesystem::path output_path(output_filename);
        auto directory = output_path.parent_path();

        // Create the log filename
        std::string log_filename = "file_group_sorter_jaccard.log";

        // Combine directory and log filename
        auto full_log_path = directory / log_filename;

        auto file_sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(full_log_path.string(), true);
        auto logger = std::make_shared<spdlog::logger>("file_logger", file_sink);
        spdlog::register_logger(logger);
    }
    catch (const spdlog::spdlog_ex &ex)
    {
        std::cout << "Log initialization failed: " << ex.what() << std::endl;
    }
}

std::mutex jaccard_cache_mutex; // Mutex for jaccard_cache
std::mutex groups_mutex;  // Mutex for groups
std::mutex progress_mutex;  // Mutex for progress

// Progress variables
int total_files = 0;
int processed_files = 0;

// Define a custom hash for std::pair<std::string, std::string>
struct pair_hash
{
    template <class T1, class T2>
    std::size_t operator () (const std::pair<T1, T2>& p) const
    {
        auto h1 = std::hash<T1> {}(p.first); // Hash the first element
        auto h2 = std::hash<T2> {}(p.second); // Hash the second element

        // Combine the two hashes
        return h1 ^ h2;
    }
};

// Jaccard similarity cache
std::unordered_map<std::pair<std::string, std::string>, double, pair_hash> jaccard_cache;

// Function to calculate Jaccard similarity between two strings
double jaccard_similarity(const std::string& a, const std::string& b)
{
    std::lock_guard<std::mutex> lock(jaccard_cache_mutex); // Lock the mutex
    {
        // Check if result is in cache
        auto it = jaccard_cache.find({a, b});
        if (it != jaccard_cache.end())
        {
            return it->second;
        }

        std::cout << "Calculating Jaccard similarity between: " << a << " and " << b << std::endl;  // Log output
        std::unordered_set<char> setA(a.begin(), a.end());
        std::unordered_set<char> setB(b.begin(), b.end());

        std::unordered_set<char> intersection;
        std::unordered_set<char> unionSet;

        for (char c : setA)
        {
            if (setB.find(c) != setB.end())
            {
                intersection.insert(c);
            }
            unionSet.insert(c);
        }

        for (char c : setB)
        {
            unionSet.insert(c);
        }

        double result = static_cast<double>(intersection.size()) / unionSet.size() * 100;

        // Store result in cache
        jaccard_cache[ {a, b}] = result;
        jaccard_cache[ {b, a}] = result; // Jaccard similarity is commutative

        return result;
    }
}

// Function to update and print progress
void update_progress()
{
    std::lock_guard<std::mutex> lock(progress_mutex);
    ++processed_files;
    double progress = (static_cast<double>(processed_files) / total_files) * 100;
    auto logger = spdlog::get("file_logger");  // Get logger
    logger->info("Progress: {:.2f}%", progress);  // Use file_logger for logging
}

// Function to group files by similarity
void group_files_by_similarity_threaded(const std::vector<std::pair<long long int, std::string>>& file_list,
                                        std::unordered_map<std::string, std::vector<std::pair<long long int, std::string>>>& groups,
                                        int start, int end)
{
    spdlog::info("Grouping files by similarity...");  // Use spdlog for logging
    for (int i = start; i < end; ++i)
    {
        const auto& [size, path] = file_list[i];
        std::string filename = path.substr(path.find_last_of("/") + 1);
        bool added = false;

        std::lock_guard<std::mutex> lock(groups_mutex); // Lock the mutex for groups
        for (const auto& [key, _] : groups)
        {
            if (jaccard_similarity(key, filename) > 90)
            {
                groups[key].push_back({size, path});
                added = true;
                break;
            }
        }

        if (!added)
        {
            groups[filename].push_back({size, path});
        }
        update_progress();
    }
}

// Main function
int main(int argc, char* argv[])
{

    if (argc != 3)
    {
        std::cout << "Usage: ./FileGroupSorter_Jaccard <input_filename> <output_filename>" << std::endl;
        return 1;
    }

    std::string input_filename = argv[1];
    std::string output_filename = argv[2];
    setup_logger(output_filename);  // Setup logger based on output_filename
    auto logger = spdlog::get("file_logger");  // Get logger

    logger->info("Program started.");  // Use spdlog for logging


    spdlog::info("Reading from input file: {}", input_filename);  // Use spdlog for logging

    std::ifstream infile(input_filename);
    if (!infile.is_open())
    {
        std::cerr << "Could not open input file." << std::endl;
        return 1;
    }

    std::ofstream outfile(output_filename);
    if (!outfile.is_open())
    {
        std::cerr << "Could not open output file." << std::endl;
        return 1;
    }

    spdlog::info("Writing to output file: {}", output_filename);  // Use spdlog for logging
    spdlog::info("Reading file content...");  // Use spdlog for logging

    std::vector<std::pair<long long int, std::string>> file_list;
    std::string line, size_str, path_str;
    long long int size;  // Use long long int for large file sizes

    // New file reading logic
    while (getline(infile, line))
    {
        std::stringstream ss(line);
        getline(ss, size_str, ',');
        getline(ss, path_str, ',');
        path_str = path_str.substr(1, path_str.length() - 2);  // Remove the double quotes
        size = std::stoll(size_str);  // Convert string to long long int
        file_list.push_back({size, path_str});
    }

    if (file_list.empty())
    {
        std::cerr << "No data read from input file. Exiting." << std::endl;
        return 1;
    }

    std::unordered_map<std::string, std::vector<std::pair<long long int, std::string>>> groups;

    // Get the number of hardware threads available on the system
    int num_threads = static_cast<int>(std::thread::hardware_concurrency());


    // If the function could not determine the number, let's default to 2 threads
    if (num_threads == 0)
    {
        num_threads = 2;
    }

    spdlog::info("Number of threads: {}", num_threads);  // Use spdlog for logging
    std::vector<std::thread> threads;
    total_files = file_list.size();  // Initialize total_files
    int chunk_size = file_list.size() / num_threads;

    for (int i = 0; i < num_threads; ++i)
    {
        int start = i * chunk_size;
        int end = (i == num_threads - 1) ? file_list.size() : start + chunk_size;
        threads.push_back(std::thread(group_files_by_similarity_threaded, std::ref(file_list), std::ref(groups), start, end));
    }

    for (auto& t : threads)
    {
        t.join();
    }

    // Sort groups by the largest file in each group
    std::vector<std::vector<std::pair<long long int, std::string>>> sorted_groups;

    for (const auto& [_, group] : groups)
    {
        sorted_groups.push_back(group);
    }

    std::sort(sorted_groups.begin(), sorted_groups.end(), [](const auto & a, const auto & b)
    {
        return a[0].first > b[0].first;
    });

    // Write to output file
    for (const auto& group : sorted_groups)
    {
        for (const auto& [size, path] : group)
        {
            outfile << size << ",\"" << path << "\"" << std::endl;
        }
        outfile << std::endl;  // Add an empty line to separate groups
    }

    logger->info("Program finished successfully.");  // Use spdlog for logging

    return 0;
}
