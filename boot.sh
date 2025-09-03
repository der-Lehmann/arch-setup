#!/bin/bash

sudo pacman -Sy --noconfirm --needed git

rm -rf ~/.local/share/arch-setup/
git clone https://github.com/der-Lehmann/arch-setup.git ~/.local/share/arch-setup >/dev/null

source ~/.local/share/arch-setup/install.sh