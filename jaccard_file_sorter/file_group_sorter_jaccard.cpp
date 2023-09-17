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
#include <leveldb/cache.h>  // Include LevelDB cache header
#include <atomic>  // Include atomic header

// Initialize LevelDB LRU Cache
leveldb::Cache* cache = leveldb::NewLRUCache(1000000000);  // 1GB cache

// 初始化LevelDB LRU缓存
leveldb::Cache* groups_cache = leveldb::NewLRUCache(1000000000);  // 1GB cache for groups

std::unordered_set<std::string> cache_keys;  // to store all keys inserted into the cache

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

std::mutex progress_mutex;  // Mutex for progress

// Progress variables
int total_files = 0;
std::atomic<int> processed_files(0);  // Make processed_files atomic

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
    // Check if result is in cache
    // Generate a cache key
    std::string cache_key = a + "_" + b;

    // Try to find the value in the cache
    leveldb::Cache::Handle* handle = cache->Lookup(cache_key);
    if (handle != nullptr)
    {
        double* cached_value = reinterpret_cast<double*>(cache->Value(handle));
        cache->Release(handle);
        return *cached_value;
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

    // Store the result in the cache
    double* heap_value = new double(result);
    cache->Insert(cache_key, heap_value, sizeof(double), [](const leveldb::Slice & key, void* value)
    {
        delete reinterpret_cast<double*>(value);
    });

    return result;
}

// Function to update and print progress
void update_progress()
{
    ++processed_files;  // Atomic operation
    double progress = (static_cast<double>(processed_files.load()) / total_files) * 100;  // Atomic read
    auto logger = spdlog::get("file_logger");  // Get logger
    logger->info("Progress: {:.2f}%", progress);  // Use file_logger for logging
}

// Function to group files by similarity
void group_files_by_similarity_threaded(const std::vector<std::pair<long long int, std::string>>& file_list,
                                        int start, int end)
{
    spdlog::info("Grouping files by similarity...");  // Use spdlog for logging
    for (int i = start; i < end; ++i)
    {
        const auto& [size, path] = file_list[i];
        std::string filename = path.substr(path.find_last_of("/") + 1);
        bool added = false;

        // Try to find a similar key in the cache
        for (const auto& key : cache_keys)
        {
            if (jaccard_similarity(key, filename) > 90)
            {
                leveldb::Cache::Handle* handle = groups_cache->Lookup(key);
                if (handle != nullptr)
                {
                    auto* similar_group = reinterpret_cast<std::vector<std::pair<long long int, std::string>>*>(groups_cache->Value(handle));
                    similar_group->push_back({size, path});
                    groups_cache->Release(handle);
                    added = true;
                    break;
                }
            }
        }

        if (!added)
        {
            // Create a new group if not found in cache
            auto* new_group = new std::vector<std::pair<long long int, std::string>>();
            new_group->push_back({size, path});
            groups_cache->Insert(filename, new_group, sizeof(new_group), [](const leveldb::Slice & key, void* value)
            {
                delete reinterpret_cast<std::vector<std::pair<long long int, std::string>>*>(value);
            });
            cache_keys.insert(filename);  // Add the new key to our set of keys
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
    file_list.reserve(20000);  // 预分配内存
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
    groups.reserve(20000);  // 预分配内存

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
        threads.push_back(std::thread(group_files_by_similarity_threaded, std::ref(file_list), start, end));
    }

    for (auto& t : threads)
    {
        t.join();
    }

    // 释放内存
    file_list.clear();
    std::vector<std::pair<long long int, std::string>>().swap(file_list);

    // Sort groups by the largest file in each group
    std::vector<std::vector<std::pair<long long int, std::string>>> sorted_groups;

    for (const auto& [_, group] : groups)
    {
        sorted_groups.push_back(group);
    }

    groups.clear();
    std::unordered_map<std::string, std::vector<std::pair<long long int, std::string>>>().swap(groups);


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

    // Release LevelDB LRU Cache
    delete cache;

    // Release LevelDB LRU Cache
    delete groups_cache;

    return 0;
}
