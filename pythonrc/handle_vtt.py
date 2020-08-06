#!/usr/bin/env python3
import datetime
import re


def parse_vtt_str(time_string):
    time_string = "00:00:08.690 --> 00:00:08.700 align:start position:0%"

    r2 = re.findall(r"\d+:\d+:\d+(?=[^:]*-->)", time_string)
    print(r2)

    date_time = datetime.datetime.strptime(r2[0], "%H:%M:%S")

    a_timedelta = date_time - datetime.datetime(1900, 1, 1)
    seconds = a_timedelta.total_seconds()

    return seconds
