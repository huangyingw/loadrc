#!/bin/zsh            
 
# Installing required packages
apt-get install -y grub-pc-bin grub-efi-amd64-bin

WORK_DIR="/tmp/my_iso"
EXCLUDE_FILE="$HOME/loadrc/zshrc/create_bootable_ubuntu_iso_exclude.conf"
ISO_PATH="/tmp/custom-ubuntu.iso" # Default path to the ISO

# Reading exclusion patterns from file
EXCLUDES=()
while read line; do
  EXCLUDES+=("--exclude=${line}")
done < "$EXCLUDE_FILE"

mkdir -p "$WORK_DIR"/casper
rsync -av --delete --progress "${EXCLUDES[@]}" / "$WORK_DIR"/casper/filesystem.root 
mksquashfs "$WORK_DIR"/casper/filesystem.root "$WORK_DIR"/casper/filesystem.squashfs -e boot

# Copying kernel and initial ramdisk
cp /boot/vmlinuz-$(uname -r) "$WORK_DIR"/casper/vmlinuz
cp /boot/initrd.img-$(uname -r) "$WORK_DIR"/casper/initrd.lz

# Creating GRUB config
mkdir -p "$WORK_DIR"/boot/grub
echo 'set timeout=10
set default=0

menuentry "Start Ubuntu" {
  linux /casper/vmlinuz boot=casper
  initrd /casper/initrd.lz
}' > "$WORK_DIR"/boot/grub/grub.cfg

# Creating ISO with GRUB
grub-mkrescue -v -o "$ISO_PATH" "$WORK_DIR"


# Cleaning up temporary files
# rm -rf "$WORK_DIR"

echo "ISO has been successfully created"
