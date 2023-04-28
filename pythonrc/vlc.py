#!/usr/bin/env python3
# vlc.py
import re


def split_string(string):
    # Split string into path and time using regex
    pattern = r"^(.*?)(?::(\d{1,2}:\d{1,2}(?::\d{1,2})?))$"
    match = re.match(pattern, string)
    if match:
        path = match.group(1)
        time = match.group(2)
        return path, time
    else:
        return None


# Example usage
string = "./mapper/usb_backup_crypt_8T_1/115download/[7sht.me]MKBD-S118-C/9 MKBD-S118-C.mp4:32:57"
path, time = split_string(string)
print(
    path
)  # ./mapper/usb_backup_crypt_8T_1/115download/[7sht.me]MKBD-S118-C/9 MKBD-S118-C.mp4
print(time)  # 32:57

string = "./mapper/usb_backup_crypt_8T_1/115download/031215_043-1pon-1080p.mp4/9 uncensored 031215_043-1pon-1080p:02:17:17"
path, time = split_string(string)
print(
    path
)  # ./mapper/usb_backup_crypt_8T_1/115download/031215_043-1pon-1080p.mp4/9 uncensored 031215_043-1pon-1080p
print(time)  # 02:17:17
