#!/bin/bash

set -e

DIRECTORY="$HOME/.local/share/arch-setup"
export DIRECTORY

source $DIRECTORY/install/yay.sh
source $DIRECTORY/install/packages.sh
source $DIRECTORY/install/display-manager.sh

source $DIRECTORY/install/config.sh