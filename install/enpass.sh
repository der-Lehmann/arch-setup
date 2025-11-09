#!/bin/bash
set -e

echo "Installing Enpass from official Enpass repository..."

TMPDIR=$(mktemp -d)
cd "$TMPDIR"

# Get the latest version from Enpass's repository
echo "Fetching latest Enpass version..."
LATEST_VERSION=$(curl -s https://apt.enpass.io/dists/stable/main/binary-amd64/Packages | awk '/^Package: enpass$/{found=1} found && /^Version:/{print $2; exit}')

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Could not determine latest Enpass version from repository"
    exit 1
fi

echo "Latest version: $LATEST_VERSION"

# Download the .deb file directly from Enpass's official repository
DEB_URL="https://apt.enpass.io/pool/main/e/enpass/enpass_${LATEST_VERSION}_amd64.deb"
echo "Downloading from: $DEB_URL"
wget -q "$DEB_URL" -O enpass.deb

# Verify the download was successful
if [ ! -f enpass.deb ] || [ ! -s enpass.deb ]; then
    echo "Error: Failed to download Enpass from official repository"
    exit 1
fi

# Extract the .deb file
echo "Extracting Enpass package..."
dpkg-deb -x enpass.deb enpass-extracted

# Install Enpass
echo "Installing Enpass..."
sudo cp -r enpass-extracted/* /

# Create desktop entry if it doesn't exist
if [ ! -f /usr/share/applications/enpass.desktop ]; then
cat <<EOF | sudo tee /usr/share/applications/enpass.desktop > /dev/null
[Desktop Entry]
Version=1.0
Name=Enpass
Comment=Password Manager
Exec=/opt/enpass/Enpass
Icon=/opt/enpass/resources/icons/enpass.png
Terminal=false
Type=Application
Categories=Utility;Security;
EOF
fi

sudo update-desktop-database

cd /
rm -rf "$TMPDIR"

echo "Enpass installed successfully from official repository!"

