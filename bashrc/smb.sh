#! /bin/sh
smbmount //192.168.0.8/volgrp  /media/smb    -o username=samba,password=ilove03180118,iocharset=utf8
smbmount //192.168.1.3/file_system  /media/mldonkey    -o username=samba,password=ilove03180118,iocharset=utf8
