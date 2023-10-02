#!/usr/bin/env python3
import sys
import subprocess

try:
    import fuzzywuzzy
except ImportError:
    subprocess.run(["pip3", "install", "fuzzywuzzy"])
    import fuzzywuzzy

from fuzzywuzzy import fuzz
from collections import defaultdict
from operator import itemgetter


# Function to group files by similarity
def group_files_by_similarity(file_list):
    groups = defaultdict(list)
    for size, path in file_list:
        filename = path.split("/")[-1]
        added = False
        for key in groups.keys():
            if fuzz.ratio(key, filename) > 80:  # 80 is a similarity threshold
                groups[key].append((size, path))
                added = True
                break
        if not added:
            groups[filename].append((size, path))
    return groups


# Function to sort files within each group by size
def sort_files_within_group(groups):
    for key in groups.keys():
        groups[key] = sorted(groups[key], key=itemgetter(0), reverse=True)
    return groups


# Function to sort groups by the largest file in each group
def sort_groups_by_largest_file(groups):
    sorted_groups = sorted(
        groups.values(), key=lambda x: max(item[0] for item in x), reverse=True
    )
    return sorted_groups


# Function to flatten the list
def flatten_list(sorted_groups):
    return [item for sublist in sorted_groups for item in sublist]


# Main function to sort files based on similarity and size
def sort_files(file_list):
    groups = group_files_by_similarity(file_list)
    sorted_groups = sort_files_within_group(groups)
    sorted_list = flatten_list(sort_groups_by_largest_file(sorted_groups))
    return sorted_list


# Main entry point
def main(input_filename, output_filename):
    # Read from input file
    with open(input_filename, "r") as infile:
        lines = infile.readlines()

    # Parse lines into a list of tuples (size, path)
    file_list = [
        (int(line.split(",")[0]), line.split(",")[1].strip()) for line in lines
    ]

    # Sort the files
    sorted_files = sort_files(file_list)

    # Write to output file
    with open(output_filename, "w") as outfile:
        last_group = None
        for size, path in sorted_files:
            current_group = path.split("/")[-1].split(".")[0]
            if last_group and fuzz.ratio(last_group, current_group) <= 80:
                outfile.write("\n")  # Add an empty line to separate groups
            outfile.write(f"{size},{path}\n")
            last_group = current_group


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(
            "Usage: python sort_similar_files_by_size.py <input_filename> <output_filename>"
        )
        print(f"Received {len(sys.argv) - 1} arguments: {sys.argv[1:]}")
    else:
        main(sys.argv[1], sys.argv[2])
