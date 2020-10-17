#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}please provide the host name... ${NC}"
    exit 1
fi
rsync -aH --force -e ssh ~/.ssh/ "$1":~/.ssh/ \
    && rsync -aH --force -e ssh ~/.ssh/ root@"$1":~/.ssh/ \
    && scp ~/loadrc/bashrc/ssh_host_* root@"$1":/etc/ssh/ \
    && rsync -aH --force -e ssh ~/.git/ "$1":~/.git/ \
    && rsync -aH --force -e ssh ~/loadrc/.git/ "$1":~/loadrc/.git/ \
    && rsync -aH --force -e ssh ~/.git/ root@"$1":~/.git/ \
    && rsync -aH --force -e ssh ~/loadrc/.git/ root@"$1":~/loadrc/.git/ \
    && rsync -aHv --progress --delete --force -e ssh ~/loadrc/grub.d/ root@"$1":/etc/grub.d/
