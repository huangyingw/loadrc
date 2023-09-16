#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

// Function to calculate Jaccard similarity between two strings
double jaccard_similarity(const std::string& a, const std::string& b) {
    std::unordered_set<char> setA(a.begin(), a.end());
    std::unordered_set<char> setB(b.begin(), b.end());

    std::unordered_set<char> intersection;
    std::unordered_set<char> unionSet;

    for (char c : setA) {
        if (setB.find(c) != setB.end()) {
            intersection.insert(c);
        }
        unionSet.insert(c);
    }

    for (char c : setB) {
        unionSet.insert(c);
    }

    return static_cast<double>(intersection.size()) / unionSet.size() * 100;
}

// Function to group files by similarity
std::unordered_map<std::string, std::vector<std::pair<int, std::string>>> group_files_by_similarity(const std::vector<std::pair<int, std::string>>& file_list) {
    std::unordered_map<std::string, std::vector<std::pair<int, std::string>>> groups;
    
    for (const auto& [size, path] : file_list) {
        std::string filename = path.substr(path.find_last_of("/") + 1);
        bool added = false;
        
        for (const auto& [key, _] : groups) {
            if (jaccard_similarity(key, filename) > 80) {
                groups[key].push_back({size, path});
                added = true;
                break;
            }
        }
        
        if (!added) {
            groups[filename].push_back({size, path});
        }
    }
    
    return groups;
}

// Main function
int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cout << "Usage: ./FileGroupSorter_Jaccard <input_filename> <output_filename>" << std::endl;
        return 1;
    }
    
    std::string input_filename = argv[1];
    std::string output_filename = argv[2];
    
    std::ifstream infile(input_filename);
    std::ofstream outfile(output_filename);
    
    std::vector<std::pair<int, std::string>> file_list;
    int size;
    std::string path;
    
    while (infile >> size >> path) {
        file_list.push_back({size, path});
    }
    
    auto groups = group_files_by_similarity(file_list);

    // Sort files within each group by size
    for (auto& [key, group] : groups) {
        std::sort(group.begin(), group.end(), [](const auto& a, const auto& b) {
            return a.first > b.first;
        });
    }

    // Sort groups by the largest file in each group
    std::vector<std::vector<std::pair<int, std::string>>> sorted_groups;
    for (const auto& [_, group] : groups) {
        sorted_groups.push_back(group);
    }

    std::sort(sorted_groups.begin(), sorted_groups.end(), [](const auto& a, const auto& b) {
        return a[0].first > b[0].first;
    });

    // Write to output file
    for (const auto& group : sorted_groups) {
        for (const auto& [size, path] : group) {
            outfile << size << " " << path << std::endl;
        }
        outfile << std::endl;  // Add an empty line to separate groups
    }

    return 0;
}
