git clone https://aur.archlinux.org/yay-bin.git

cd yay-bin

makepkg -s --noconfirm
sudo pacman -U --noconfirm *.pkg.tar.zst

cd ..
rm -rf yay-bin