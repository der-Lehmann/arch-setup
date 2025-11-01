#!/bin/bash

# Set up SDDM display manager for graphical login
echo "Setting up SDDM display manager..."
sudo mkdir -p /etc/sddm.conf.d

if [ ! -f /etc/sddm.conf.d/autologin.conf ]; then
  cat <<EOF | sudo tee /etc/sddm.conf.d/autologin.conf
[Autologin]
User=$USER
Session=hyprland-uwsm
EOF
fi

sudo systemctl enable sddm.service
