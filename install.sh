#!/bin/bash

set -e

DIRECTORY="$HOME/.local/share/arch-setup"

source $DIRECTORY/install/yay.sh
source $DIRECTORY/install/packages.sh
source $DIRECTORY/install/walker.sh
source $DIRECTORY/install/display-manager.sh