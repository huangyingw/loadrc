import unittest
from sort_similar_files_by_size import (
    group_files_by_similarity,
    sort_files_within_group,
    sort_groups_by_largest_file,
    sort_files,
)


class TestSortSimilarFilesBySize(unittest.TestCase):
    def test_group_files_by_similarity(self):
        file_list = [(10, "file1.mp4"), (20, "file2.mp4"), (30, "file3.txt")]
        result = group_files_by_similarity(file_list)
        self.assertEqual(len(result), 2)

    def test_sort_files_within_group(self):
        groups = {"file.mp4": [(10, "file1.mp4"), (20, "file2.mp4")]}
        result = sort_files_within_group(groups)
        self.assertEqual(result["file.mp4"][0][0], 20)

    def test_sort_groups_by_largest_file(self):
        groups = {
            "file.mp4": [(10, "file1.mp4"), (20, "file2.mp4")],
            "file.txt": [(5, "file3.txt")],
        }
        sorted_groups = sort_groups_by_largest_file(groups)
        largest_file_in_first_group = max(item[0] for item in sorted_groups[0])
        self.assertEqual(largest_file_in_first_group, 20)

    def test_sort_files(self):
        file_list = [(10, "file1.mp4"), (20, "file2.mp4"), (5, "file3.txt")]
        result = sort_files(file_list)
        self.assertEqual(result[0][0], 20)


if __name__ == "__main__":
    unittest.main()
