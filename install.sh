#!/bin/bash

set -e

DIRECTORY="$HOME/.local/share/arch-setup"
export DIRECTORY

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

source $DIRECTORY/install/locale.sh

source $DIRECTORY/install/config.sh

source $DIRECTORY/install/snap.sh

chsh -s $(which zsh)