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
# Check if squashfs is already available (built into kernel or already loaded)
if ! grep -q squashfs /proc/filesystems && ! lsmod | grep -q squashfs; then
    # Update module dependencies
    sudo depmod -a
    
    # Try to load the module
    if ! sudo modprobe squashfs 2>/dev/null; then
        # If modprobe fails, try to find and load the module directly
        MODULE_PATH=$(find /lib/modules/$(uname -r) -name "squashfs.ko*" 2>/dev/null | head -1)
        if [ -n "$MODULE_PATH" ]; then
            sudo insmod "$MODULE_PATH" 2>/dev/null || true
        fi
    fi
fi

sudo systemctl enable --now snapd.socket

sudo systemctl enable --now snapd.apparmor.service

sudo ln -sf /var/lib/snapd/snap /snap

cd /
rm -rf "$TMPDIR"