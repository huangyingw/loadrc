#!/bin/bash
sshfs -o idmap=user huangyingw@ubuntu:/media/ /media/samba/
if [ $? -ne 0 ]; then
    sshfs -o idmap=user huangyingw@vdonkey:/media/ /media/samba/
fi
