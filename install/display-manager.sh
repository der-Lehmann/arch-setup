#!/bin/bash

# Set up SDDM display manager for graphical login

echo "Setting up SDDM display manager..."

# Enable SDDM service to start at boot
sudo systemctl enable sddm.service

# Create SDDM configuration directory if it doesn't exist
sudo mkdir -p /etc/sddm.conf.d/

# Configure SDDM for Wayland support
sudo tee /etc/sddm.conf.d/10-wayland.conf > /dev/null << 'EOF'
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
CompositorCommand=Hyprland
EOF

echo "SDDM display manager has been configured!"
echo "After reboot, you'll see a graphical login screen where you can:"
echo "  - Choose between available desktop environments"
echo "  - Login with your user credentials" 
echo "  - SDDM will automatically start your selected environment"
