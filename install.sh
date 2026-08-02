#!/bin/bash

set -e

DIRECTORY="$HOME/.local/share/arch-setup"
export DIRECTORY

# Mirror all output to a log file while still printing to the terminal
LOG_FILE="$DIRECTORY/install-$(date +%Y%m%d-%H%M%S).log"
mkdir -p "$(dirname "$LOG_FILE")"
exec > >(tee -a "$LOG_FILE") 2>&1
echo "Logging install output to $LOG_FILE"

sudo -v

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel

source $DIRECTORY/install/yay.sh
source $DIRECTORY/install/display-manager.sh
source $DIRECTORY/install/packages.sh
source $DIRECTORY/install/fonts.sh
source $DIRECTORY/install/devtools.sh
source $DIRECTORY/install/docker.sh
source $DIRECTORY/install/webapps.sh
source $DIRECTORY/install/enpass.sh
source $DIRECTORY/install/vscode.sh
source $DIRECTORY/install/cursor.sh

source $DIRECTORY/install/networkmanager.sh
source $DIRECTORY/install/services.sh
source $DIRECTORY/install/firewall.sh

source $DIRECTORY/install/locale.sh

source $DIRECTORY/install/config.sh

source $DIRECTORY/install/snap.sh

chsh -s $(which zsh)