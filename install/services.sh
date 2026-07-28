sudo systemctl enable iwd.service

# Caps Lock dual-role (tap Esc / hold AltGr) — config in config/keyd/
sudo mkdir -p /etc/keyd
sudo cp "$DIRECTORY/config/keyd/default.conf" /etc/keyd/default.conf
sudo systemctl enable --now keyd.service
