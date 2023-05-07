import difflib

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

def find_close_files(file_names, threshold=0.8):
    close_files = []

    for i, file_name_1 in enumerate(file_names):
        for j, file_name_2 in enumerate(file_names):
            if i != j:
                similarity = difflib.SequenceMatcher(None, file_name_1, file_name_2).ratio()
                if similarity >= threshold:
                    close_files.append((file_name_1, file_name_2))

    return close_files

threshold = 0.8
close_files = find_close_files(file_names, threshold)
print(close_files)
