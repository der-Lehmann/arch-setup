echo "Installing Cursor..."
yay -S --noconfirm cursor-bin

mkdir -p ~/.cursor ~/.config/Cursor/User

cat > ~/.cursor/argv.json << 'EOF'
// This configuration file allows you to pass permanent command line arguments to Cursor.
// Only a subset of arguments is currently supported to reduce the likelihood of breaking
// the installation.
//
// PLEASE DO NOT CHANGE WITHOUT UNDERSTANDING THE IMPACT
//
// NOTE: Changing this file requires a restart of Cursor.
{
  "password-store":"gnome-libsecret"
}
EOF

printf '{\n  "update.mode": "none"\n}\n' > ~/.config/Cursor/User/settings.json
