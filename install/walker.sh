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
    rust \
    cargo \
    go \
    git \
    make \
    pkg-config

echo "Installing Elephant..."
if ! command -v elephant &> /dev/null; then
    echo "Building Elephant from source..."
    cd /tmp
    git clone https://github.com/abenz1267/elephant.git
    cd elephant
    
    # Build and install the main binary
    cd cmd/elephant
    go install elephant.go
    
    # Create configuration directories
    mkdir -p ~/.config/elephant/providers
    
    # Build and install desktop applications provider
    cd ../internal/providers/desktopapplications
    go build -buildmode=plugin
    cp desktopapplications.so ~/.config/elephant/providers/
    
    cd /tmp
    rm -rf elephant
    echo "Elephant installed successfully"
else
    echo "Elephant is already installed"
fi

# Install Walker
echo "Installing Walker..."
if ! command -v walker &> /dev/null; then
    echo "Building Walker from source..."
    cd /tmp
    git clone https://github.com/abenz1267/walker.git
    cd walker
    cargo build --release
    sudo cp target/release/walker /usr/local/bin/
    cd ..
    rm -rf walker
    echo "Walker installed successfully"
else
    echo "Walker is already installed"
fi