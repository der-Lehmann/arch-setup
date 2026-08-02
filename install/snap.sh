#!/bin/bash
set -e
TMPDIR=$(mktemp -d)
cd "$TMPDIR"

git clone https://aur.archlinux.org/snapd.git
cd snapd

makepkg -s --noconfirm
sudo pacman -U --noconfirm *.pkg.tar.zst

sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.service
sudo systemctl enable --now snapd.apparmor.service

sudo ln -sf /var/lib/snapd/snap /snap

# Wait for snapd to finish initial seeding before installing snaps
echo "Waiting for snapd to be ready..."
if ! timeout 120 snap wait system seed.loaded; then
  echo "snapd failed to become ready (seed.loaded)" >&2
  exit 1
fi

cd /
rm -rf "$TMPDIR"

sudo snap install todoist
sudo snap install obsidian --classic
sudo snap install localsend