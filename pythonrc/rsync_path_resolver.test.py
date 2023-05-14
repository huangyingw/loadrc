import unittest
from unittest.mock import patch
from rsync_path_resolver import resolve_rsync_path, parse_host, get_rsyncpath


class TestRsyncPathResolver(unittest.TestCase):
    def test_parse_host(self):
        self.assertEqual(parse_host("localhost:/path"), "localhost")
        self.assertEqual(
            parse_host("user@remotehost:/path"), "user@remotehost"
        )
        self.assertEqual(parse_host("/local/path"), "localhost")

    @patch("subprocess.check_output")
    def test_get_rsyncpath(self, mock_check_output):
        mock_check_output.return_value = "/usr/bin/rsync\n"
        self.assertEqual(get_rsyncpath("localhost"), "/usr/bin/rsync")
        self.assertEqual(get_rsyncpath("user@remotehost"), "/usr/bin/rsync")

    def test_resolve_rsync_path(self):
        with patch("rsync_path_resolver.get_rsyncpath") as mock_get_rsyncpath:
            mock_get_rsyncpath.return_value = "/usr/bin/rsync"
            rsync_path_option = resolve_rsync_path(
                "local_source_folder", "user@remotehost:/remote/path"
            )
            self.assertEqual(rsync_path_option, "--rsync-path=/usr/bin/rsync")


if __name__ == "__main__":
    unittest.main()
