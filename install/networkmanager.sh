sudo install -d /etc/NetworkManager/conf.d

sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null <<'EOF'
[device]
wifi.backend=iwd
EOF

# NetworkManager owns networking; disable systemd-networkd so wait-online
# doesn't block graphical.target (and delay UWSM/Hyprland startup).
sudo systemctl disable --now \
  systemd-networkd.service \
  systemd-networkd.socket \
  systemd-networkd-wait-online.service

sudo systemctl enable NetworkManager.service
