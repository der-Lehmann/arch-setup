#!/bin/bash
set -e
TMPDIR=$(mktemp -d)
cd "$TMPDIR"

git clone https://aur.archlinux.org/snapd.git
cd snapd

makepkg -s --noconfirm
sudo pacman -U --noconfirm *.pkg.tar.zst

# Load squashfs kernel module immediately (required for snapd)
# The module is installed with snapd but not automatically loaded until reboot
sudo modprobe squashfs

sudo systemctl enable --now snapd.socket

sudo systemctl enable --now snapd.apparmor.service

sudo ln -sf /var/lib/snapd/snap /snap

cd /
rm -rf "$TMPDIR"