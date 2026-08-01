# Firewall (ufw). Rules persist in /etc/ufw/user.rules once applied;
# re-running this script is safe, ufw skips existing rules.

sudo ufw default deny incoming
sudo ufw default allow outgoing

# Xdebug: PHP containers connect back to the IDE on the host (port 9003).
# 172.16.0.0/12 covers the default Docker bridge and all compose networks.
sudo ufw allow from 172.16.0.0/12 to any port 9003 proto tcp comment 'Xdebug from Docker'

sudo ufw --force enable
sudo systemctl enable ufw.service
