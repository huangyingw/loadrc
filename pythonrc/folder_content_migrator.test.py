import os
import unittest
import tempfile
import shutil
from folder_content_migrator import move_folders


class TestFolderContentMigrator(unittest.TestCase):
    def setUp(self):
        # Create a temporary directory
        self.source_folder = tempfile.mkdtemp()
        self.target_folder = tempfile.mkdtemp()

        # Create a file in the source folder
        self.file_path = os.path.join(self.source_folder, "testfile.txt")
        with open(self.file_path, "w") as f:
            f.write("Hello, World!")

    def tearDown(self):
        # Remove temporary directories
        shutil.rmtree(self.source_folder)
        shutil.rmtree(self.target_folder)

    def test_move_folders(self):
        move_folders(self.source_folder, self.target_folder)

        # Check if the file has been moved
        self.assertFalse(os.path.exists(self.file_path))
        self.assertTrue(
            os.path.exists(os.path.join(self.target_folder, "testfile.txt"))
        )

    def test_no_overwriting(self):
        # Create a file with the same name in the target folder
        duplicate_file_path = os.path.join(self.target_folder, "testfile.txt")
        with open(duplicate_file_path, "w") as f:
            f.write("Hello, Universe!")

        move_folders(self.source_folder, self.target_folder)

        # Check that the original file was not overwritten
        with open(duplicate_file_path, "r") as f:
            content = f.read()
        self.assertEqual(content, "Hello, Universe!")

    def test_empty_directories_removed(self):
        # Create an empty directory in the source folder
        empty_dir_path = os.path.join(self.source_folder, "empty_dir")
        os.makedirs(empty_dir_path)

        # Create a non-empty directory in the source folder
        non_empty_dir_path = os.path.join(self.source_folder, "non_empty_dir")
        os.makedirs(non_empty_dir_path)
        with open(os.path.join(non_empty_dir_path, "file.txt"), "w") as f:
            f.write("Hello!")

        move_folders(self.source_folder, self.target_folder)

        # Check that the empty directory has been removed
        self.assertFalse(os.path.exists(empty_dir_path))

        # Check that the non-empty directory has not been removed
        self.assertTrue(os.path.exists(non_empty_dir_path))


if __name__ == "__main__":
    unittest.main()
