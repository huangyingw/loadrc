#!/usr/bin/env python3

"""
find_similar_filenames.py
"""

import argparse
import difflib
import os
import re

file_size_cache = {}

def get_file_size(file_path, default_size=0):
    # Remove quotation marks from the file path
    file_path = file_path.replace('"', '')

    if file_path in file_size_cache:
        return file_size_cache[file_path]

    try:
        if os.path.isfile(file_path):
            size = os.path.getsize(file_path)
        else:
            print(f"File does not exist: {file_path}")
            print("Absolute path:", os.path.abspath(file_path))
            print("Current directory:", os.getcwd())
            size = default_size
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        print("Absolute path:", os.path.abspath(file_path))
        print("Current directory:", os.getcwd())
        size = default_size

    file_size_cache[file_path] = size
    return size

def extract_file_name(file_path):
    return file_path.split("/")[-1].lower()

def extract_keywords(file_names):
    pattern = re.compile(r'\b(?:\d{2}\.\d{2}\.\d{2}|(?:\d+|[a-z]+(?:\d+[a-z]*)?))\b', re.IGNORECASE)
    keywords = set()
    for file_name in file_names:
        name_without_ext = os.path.splitext(file_name)[0]
        matches = pattern.findall(name_without_ext)
        keywords.update(matches)
    return list(keywords)

def find_close_files(file_names, file_paths, keywords):
    close_files = {kw: [] for kw in keywords}

    for kw in keywords:
        for file_name, file_path in zip(file_names, file_paths):
            if kw.lower() in file_name.lower():
                close_files[kw].append(file_path)

    return close_files

def main(file_paths):
    file_names = [extract_file_name(fp) for fp in file_paths]
    keywords = extract_keywords(file_names)
    close_files = find_close_files(file_names, file_paths, keywords)

    # Sort the keywords by the length of their corresponding keyword_files in descending order
    sorted_keywords = sorted(keywords, key=lambda kw: len(close_files[kw]), reverse=True)

    for keyword in sorted_keywords:
        keyword_files = list(set(close_files[keyword]))
        keyword_files.sort(key=lambda x: get_file_size(x), reverse=True)  # Updated line
        if 2 <= len(keyword_files) <= 30:
            print(f"{keyword}.txt")
            with open(f"{keyword}.txt", "w") as f:
                f.write(keyword + "\n")
                for file_path in keyword_files:
                    f.write(file_path + "\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--file", help="A file containing newline-separated file paths")
    args = parser.parse_args()

    with open(args.file, 'r') as file:
        file_paths = [line.strip() for line in file.readlines()]

    main(file_paths)
