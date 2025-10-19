#!/bin/bash

set -e
echo "Installing Walker application launcher..."

echo "Installing dependencies..."
sudo pacman -Sy --noconfirm --needed \
    gtk4 \
    gtk4-layer-shell \
    protobuf \
    cairo \
    poppler-glib \
    poppler

echo "Installing Elephant..."
if ! command -v elephant &> /dev/null; then
    echo "Installing Elephant via yay..."
    yay -S --noconfirm elephant
    
    echo "Installing Elephant providers..."
    yay -S --noconfirm elephant-desktopapplications
    echo "Elephant installed successfully"
else
    echo "Elephant is already installed"
fi

# Install Walker
echo "Installing Walker..."
if ! command -v walker &> /dev/null; then
    echo "Installing Walker via yay..."
    yay -S --noconfirm walker
    echo "Walker installed successfully"
else
    echo "Walker is already installed"
fi