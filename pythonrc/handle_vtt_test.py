#!/usr/bin/env python3
from handle_vtt import *
import unittest


class TestHandle_Vtt(unittest.TestCase):
    def test_parse_vtt_str(self):
        time_string = "00:00:08.690 --> 00:00:08.700 align:start position:0%"
        start = parse_vtt_str(time_string)
        self.assertEqual(start, 8.0)
        time_string = "00:10:08.690 --> 00:00:08.700 align:start position:0%"
        start = parse_vtt_str(time_string)
        self.assertEqual(start, 608.0)

    def test_find_vtt_video(self):
        fileVar = "/Users/huangyingw/Dropbox/learning/AI/fast.ai/Intro_to_Machine_Learning_-_Lesson_1.en.vtt"
        videoFile = find_vtt_video(fileVar)
        self.assertEqual(videoFile, '/Users/huangyingw/Dropbox/learning/AI/fast.ai/Intro_to_Machine_Learning_-_Lesson_1.mkv')


if __name__ == '__main__':
    unittest.main()
