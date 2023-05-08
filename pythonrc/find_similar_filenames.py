import difflib
import os
import re
import nltk

def get_file_size(file_path, default_size=0):
    try:
        return os.path.getsize(file_path)
    except FileNotFoundError:
        return default_size

file_paths = [
    "./mapper/usb_backup_crypt_8T_1/115download/abp-566-4K.mp4",
    "./huangyingw/761f02d8-0d60-43b3-a6fb-0a97746dc0da/115download/abp-566-4K.mp4",
    "./mapper/usb_backup_crypt_8T_1/115download/ABP-566.mp4",
    "./huangyingw/761f02d8-0d60-43b3-a6fb-0a97746dc0da/115download/MXGS-884-4K.mp4",
    "./huangyingw/761f02d8-0d60-43b3-a6fb-0a97746dc0da/115download/MXGS-5664K.mp4"
]

def extract_file_name(file_path):
    return file_path.split("/")[-1].lower()

file_names = [extract_file_name(fp) for fp in file_paths]

def extract_keywords(file_names):
    pattern = re.compile(r'\b(?:\d+|[a-z]+(?:\d+[a-z]*)?)\b', re.IGNORECASE)
    keywords = set()
    for file_name in file_names:
        # Remove file extension
        name_without_ext = os.path.splitext(file_name)[0]
        matches = pattern.findall(name_without_ext)
        keywords.update(matches)
    return list(keywords)

def find_close_files(file_names, keywords):
    close_files = {kw: [] for kw in keywords}

    for kw in keywords:
        for file_name, file_path in zip(file_names, file_paths):
            if kw.lower() in file_name.lower():
                close_files[kw].append(file_path)

    return close_files

keywords = extract_keywords(file_names)
close_files = find_close_files(file_names, keywords)

for keyword in keywords:
    keyword_files = list(set(close_files[keyword]))
    keyword_files.sort(key=lambda x: get_file_size(x))
    print(f"{keyword}:")
    for file_path in keyword_files:
        print(f'"{file_path}",')
    print()
