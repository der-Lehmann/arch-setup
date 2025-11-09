#!/bin/bash
set -e

git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -s --noconfirm
sudo pacman -U --noconfirm *.pkg.tar.zst

sudo systemctl enable --now snapd.socket

sudo systemctl enable --now snapd.apparmor.service

sudo ln -s /var/lib/snapd/snap /snap