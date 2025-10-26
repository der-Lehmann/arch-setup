#!/bin/bash

set -e
echo "Installing Walker application launcher..."

# Install Rust using rustup to ensure proper LLVM compatibility
echo "Setting up Rust..."
if ! command -v rustup &> /dev/null; then
    echo "Installing rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "Rust toolchain installed via rustup"
else
    echo "Rustup already installed"
    source "$HOME/.cargo/env"
fi

# Install stable Rust toolchain
rustup install stable
rustup default stable

echo "Installing dependencies..."
sudo pacman -Sy --noconfirm --needed \
    gtk4 \
    gtk4-layer-shell \
    protobuf \
    cairo \
    poppler-glib \
    poppler \
    git \
    pkg-config \
    curl

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
    echo "Building Walker from source..."
    source "$HOME/.cargo/env"
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