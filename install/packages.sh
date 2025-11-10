sudo pacman -Sy --noconfirm --needed \
    alacritty \
    blueberry \
    brightnessctl \
    btop \
    chromium \
    curl \
    docker \
    dpkg \
    dunst \
    ffmpegthumbnailer \
    firefox \
    gnome-calculator \
    gnome-keyring \
    gvfs-mtp \
    gvfs-smb \
    hyprland \
    hypridle \
    hyprlock \
    hyprpaper \
    hyprpicker \
    hyprsunset \
    kitty \
    less \
    libreoffice-still \
    man-db \
    nautilus \
    noto-fonts \
    noto-fonts-emoji \
    pipewire \
    polkit-gnome \
    qt5-wayland \
    qt6-wayland \
    remmina \
    sushi \
    tmux \
    otf-font-awesome \
    unzip \
    uwsm \
    vim \
    vlc \
    waybar \
    wget \
    wireplumber \
    wl-clipboard \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-hyprland

# Run yay and suppress desktop file cache update errors
# On bare Arch installations, the desktop file cache may not be initialized yet
# The packages are still installed successfully even if the cache update fails
# The error "too early for operation" is non-critical and can be safely ignored
yay -S --noconfirm walker elephant elephant-desktopapplications brave-bin spotify

sudo snap install todoist
sudo snap install obsidian --classic
sudo snap install localsend