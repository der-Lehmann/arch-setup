sudo pacman -S --needed --noconfirm \
    docker \
    docker-buildx \
    docker-compose

sudo systemctl enable --now docker.service

if ! getent group docker >/dev/null; then
    sudo groupadd docker
fi

if ! id -nG "$USER" | grep -qw docker; then
    sudo usermod -aG docker "$USER"
fi
