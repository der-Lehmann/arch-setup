mkdir -p ~/.local/share/applications/icons

cp $DIRECTORY/install/icons/* ~/.local/share/applications/icons/

cat <<EOF >~/.local/share/applications/WhatsApp.desktop
[Desktop Entry]
Version=1.0
Name=WhatsApp
Comment=WhatsApp Messenger
# The profile-directory option may need to be changed. Look for the "Profile Path" entry on this page: brave://version
Exec=brave-browser --profile-directory="Profile 1" --app="https://web.whatsapp.com" --name=WhatsApp --class=Whatsapp
Terminal=false
Type=Application
Icon=$HOME/.local/share/applications/icons/WhatsApp.png
Categories=Network;InstantMessaging;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF

cat <<EOF >~/.local/share/applications/Teams.desktop
[Desktop Entry]
Version=1.0
Name=Teams
Comment=Microsoft Teams
Exec=chromium --app="https://teams.microsoft.com" --name=Teams --class=Teams
Terminal=false
Type=Application
Icon=$HOME/.local/share/applications/icons/Teams.png
Categories=Network;InstantMessaging;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF

cat <<EOF >~/.local/share/applications/Outlook.desktop
[Desktop Entry]
Version=1.0
Name=Outlook
Comment=Microsoft Outlook
Exec=chromium --app="https://outlook.office.com" --name=Outlook --class=Outlook
Terminal=false
Type=Application
Icon=$HOME/.local/share/applications/icons/Outlook.png
Categories=Network;Email;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF