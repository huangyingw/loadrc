#include <iostream>
#include <filesystem>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <iomanip>
#include <leveldb/cache.h>  // Include LevelDB cache header
#include <atomic>  // Include atomic header
#include <tbb/parallel_for.h>
#include <tbb/blocked_range.h>
#include "xxhash.h"  // Include xxHash header

// Initialize LevelDB LRU Cache
leveldb::Cache* cache = leveldb::NewLRUCache(1000000000);  // 1GB cache

// Initialize LevelDB LRU cache for groups
leveldb::Cache* groups_cache = leveldb::NewLRUCache(1000000000);  // 1GB cache for groups

std::unordered_set<std::string> cache_keys;  // to store all keys inserted into the cache

// Generate a sorted cache key for two strings
std::string generate_cache_key(const std::string& a, const std::string& b)
{
    // Determine the order of strings to avoid sorting
    std::string concatenated = (a < b) ? (a + "_" + b) : (b + "_" + a);

    // Hash the concatenated string using xxHash
    unsigned long long hash_value = XXH64(concatenated.c_str(), concatenated.size(), 0);

    return std::to_string(hash_value);
}

// Progress variables
int total_files = 0;
std::atomic<int> processed_files(0);  // Make processed_files atomic


// Function to calculate Jaccard similarity between two strings
double jaccard_similarity(const std::string& a, const std::string& b)
{
    // Check if result is in cache
    // Generate a sorted cache key
    std::string cache_key = generate_cache_key(a, b);

    // Try to find the value in the cache
    leveldb::Cache::Handle* handle = cache->Lookup(cache_key);
    if (handle != nullptr)
    {
        double* cached_value = reinterpret_cast<double*>(cache->Value(handle));
        cache->Release(handle);
        return *cached_value;
    }

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
    std::cout << "Progress: " << std::fixed << std::setprecision(2) << progress << "%" << std::endl;
}

// Function to group files by similarity using Intel TBB
void group_files_by_similarity_tbb(const std::vector<std::pair<long long int, std::string>>& file_list)
{
    tbb::parallel_for(tbb::blocked_range<size_t>(0, file_list.size()), [&](const tbb::blocked_range<size_t>& r)
    {
        for (size_t i = r.begin(); i != r.end(); ++i)
        {
            const auto& [size, path] = file_list[i];
            std::string filename = path.substr(path.find_last_of("/") + 1);
            bool added = false;

            // Try to find a similar key in the cache
            for (const auto& key : cache_keys)
            {
                if (jaccard_similarity(key, filename) > 70)
                {
                    leveldb::Cache::Handle* handle = groups_cache->Lookup(key);
                    if (handle != nullptr)
                    {
                        auto* group = reinterpret_cast<std::vector<std::pair<long long int, std::string>>*>(groups_cache->Value(handle));
                        group->push_back({size, path});
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
    });
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

    std::ifstream infile(input_filename);
    if (!infile.is_open())
    {
        std::cerr << "Could not open input file." << std::endl;
        return 1;
    }



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

    total_files = file_list.size();  // Initialize total_files

    // Use TBB's parallel_for for file grouping
    group_files_by_similarity_tbb(file_list);

    // 释放内存
    file_list.clear();

    // Sort groups by the largest file in each group
    std::vector<std::vector<std::pair<long long int, std::string>>> sorted_groups;

    // Retrieve groups from cache
    for (const auto& key : cache_keys)
    {
        leveldb::Cache::Handle* handle = groups_cache->Lookup(key);
        if (handle != nullptr)
        {
            auto* group = reinterpret_cast<std::vector<std::pair<long long int, std::string>>*>(groups_cache->Value(handle));
            sorted_groups.push_back(*group);
            groups_cache->Release(handle);
        }
    }

    std::sort(sorted_groups.begin(), sorted_groups.end(), [](const auto & a, const auto & b)
    {
        return a[0].first > b[0].first;
    });

    // Write to output file
    std::ostringstream oss;
    for (const auto& group : sorted_groups)
    {
        for (const auto& [size, path] : group)
        {
            oss << size << ",\"" << path << "\"\n";
        }
        oss << '\n';
    }

    std::ofstream outfile(output_filename);

    if (!outfile.is_open())
    {
        std::cerr << "Could not open output file." << std::endl;
        return 1;
    }
    outfile << oss.str();

    // Release LevelDB LRU Cache
    delete cache;

    // Release LevelDB LRU Cache
    delete groups_cache;

    return 0;
}
