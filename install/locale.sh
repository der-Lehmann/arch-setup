if ! locale -a | grep -qiE '^de_DE\.utf-?8$'; then
    sudo sed -i 's/^#\s*\(de_DE\.UTF-8 UTF-8\)/\1/' /etc/locale.gen
    sudo locale-gen
fi
