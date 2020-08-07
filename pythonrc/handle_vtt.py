#!/usr/bin/env python3
from os import path
import datetime
import re


def parse_vtt_str(time_string):
    r2 = re.findall(r"\d+:\d+:\d+(?=[^:]*-->)", time_string)
    date_time = datetime.datetime.strptime(r2[0], "%H:%M:%S")
    a_timedelta = date_time - datetime.datetime(1900, 1, 1)
    seconds = a_timedelta.total_seconds()
    return seconds


def find_vtt_video(filename):
    regex = r".+(?=\.en\.(vtt|srt)$)"
    matches = re.finditer(regex, filename, re.MULTILINE)
    for matchNum, match in enumerate(matches, start=1):
        for postfix in ["mp4", "mkv"]:
            targetFile = match.group() + "." + postfix
            if path.exists(targetFile):
                return targetFile
