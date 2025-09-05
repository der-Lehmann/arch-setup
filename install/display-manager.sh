#!/bin/bash

# Set up SDDM display manager for graphical login
echo "Setting up SDDM display manager..."
sudo systemctl enable sddm.service
