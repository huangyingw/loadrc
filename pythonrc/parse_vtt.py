#!/usr/bin/env python
import datetime

time_string = "00:00:08.690 --> 00:00:08.700 align:start position:0%"
date_time = datetime.datetime.strptime(time_string, "%H:%M:%S")

print(date_time)

a_timedelta = date_time - datetime.datetime(1900, 1, 1)
seconds = a_timedelta.total_seconds()

print(seconds)
