#!/usr/bin/env python3
from handle_vtt import parse_vtt_str
import unittest


class TestHandle_Vtt(unittest.TestCase):

    def test_parse_vtt_str(self):
        time_string = "00:00:08.690 --> 00:00:08.700 align:start position:0%"
        start = parse_vtt_str(time_string)
        self.assertEqual(start, 8.0)

        time_string = "00:10:08.690 --> 00:00:08.700 align:start position:0%"
        start = parse_vtt_str(time_string)
        self.assertEqual(start, 608.0)


if __name__ == '__main__':
    unittest.main()
