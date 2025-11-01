cd /tmp
sudo rm -rf /tmp/font
mkdir /tmp/font
cd /tmp/font

curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip
unzip -o ./JetBrainsMono.zip -d /tmp/font
unzip -o ./Meslo.zip -d /tmp/font

sudo mkdir -p /usr/share/fonts/TTF
sudo cp -f /tmp/font/*.ttf /usr/share/fonts/TTF/
sudo fc-cache -f -v
sudo rm -rf /tmp/font
cd -