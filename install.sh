#!/bin/bash

set -e

DIRECTORY="$HOME/.local/share/arch-setup"
export DIRECTORY

sudo pacman -Syu

source $DIRECTORY/install/yay.sh
source $DIRECTORY/install/packages.sh
source $DIRECTORY/install/display-manager.sh
source $DIRECTORY/install/fonts.sh
source $DIRECTORY/install/devtools.sh
source $DIRECTORY/install/webapps.sh

source $DIRECTORY/install/config.sh