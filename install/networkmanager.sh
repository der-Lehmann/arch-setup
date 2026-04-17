sudo install -d /etc/NetworkManager/conf.d

sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf >/dev/null <<'EOF'
[device]
wifi.backend=iwd
EOF

sudo systemctl enable NetworkManager.service
