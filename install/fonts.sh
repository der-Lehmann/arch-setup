cd /tmp
sudo rm -rf /tmp/font
mkdir /tmp/font
cd /tmp/font

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip
unzip -o /tmp/JetBrainsMono.zip -d /tmp/font
unzip -o /tmp/Meslo.zip -d /tmp/font

sudo cp -f /tmp/font/*.ttf /usr/local/share/fonts/
sudo fc-cache -f -v
sudo rm -rf /tmp/font
cd -