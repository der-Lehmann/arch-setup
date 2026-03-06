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

# Wait for snapd to finish initial seeding before installing snaps
echo "Waiting for snapd to be ready..."
for i in {1..30}; do
  if snap list >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

cd /
rm -rf "$TMPDIR"

sudo snap install todoist
sudo snap install obsidian --classic
sudo snap install localsend