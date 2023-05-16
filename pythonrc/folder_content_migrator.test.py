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


if __name__ == "__main__":
    unittest.main()
