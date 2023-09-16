#include <iostream>
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

std::mutex jaccard_cache_mutex; // Mutex for jaccard_cache

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

std::mutex groups_mutex; // Mutex for groups

// Function to group files by similarity
void group_files_by_similarity_threaded(const std::vector<std::pair<long long int, std::string>>& file_list,
                                        std::unordered_map<std::string, std::vector<std::pair<long long int, std::string>>>& groups,
                                        int start, int end)
{
    std::cout << "Grouping files by similarity..." << std::endl;  // Log output
    for (int i = start; i < end; ++i)
    {
        const auto& [size, path] = file_list[i];
        std::string filename = path.substr(path.find_last_of("/") + 1);
        bool added = false;

        std::lock_guard<std::mutex> lock(groups_mutex); // Lock the mutex for groups
        for (const auto& [key, _] : groups)
        {
            if (jaccard_similarity(key, filename) > 80)
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
    }
}

// Main function
int main(int argc, char* argv[])
{
    std::cout << "Program started." << std::endl;  // Log output

    if (argc != 3)
    {
        std::cout << "Usage: ./FileGroupSorter_Jaccard <input_filename> <output_filename>" << std::endl;
        return 1;
    }

    std::string input_filename = argv[1];
    std::string output_filename = argv[2];

    std::cout << "Reading from input file: " << input_filename << std::endl;  // Log output

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

    std::cout << "Writing to output file: " << output_filename << std::endl;  // Log output
    std::cout << "Reading file content..." << std::endl;  // Log output

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

    std::cout << "Number of threads: " << num_threads << std::endl;
    std::vector<std::thread> threads;
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

    std::cout << "Program finished successfully." << std::endl;  // Log output

    return 0;
}
