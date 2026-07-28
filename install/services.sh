sudo systemctl enable iwd.service

# Caps Lock dual-role (tap Esc / hold AltGr) — config in config/keyd/
sudo mkdir -p /etc/keyd
sudo cp "$DIRECTORY/config/keyd/default.conf" /etc/keyd/default.conf
sudo systemctl enable --now keyd.service

# Store ssh keys in the keychain for the session once unlocked
systemctl --user enable --now gcr-ssh-agent.socket gnome-keyring-daemon.socket
