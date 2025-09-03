# These packages are only required when arch is run on a computer with a nividia gpu.

sudo pacman -Sy --noconfirm --needed \
    nvidia \
    nvidia-utils \
    vulkan-icd-loader \
    vulkan-tools