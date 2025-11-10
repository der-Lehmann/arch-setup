#!/bin/bash
set -e
TMPDIR=$(mktemp -d)
cd "$TMPDIR"

git clone https://aur.archlinux.org/snapd.git
cd snapd

makepkg -s --noconfirm
sudo pacman -U --noconfirm *.pkg.tar.zst

sudo systemctl enable --now snapd.socket

sudo systemctl enable --now snapd.apparmor.service

sudo ln -sf /var/lib/snapd/snap /snap

cd /
rm -rf "$TMPDIR"