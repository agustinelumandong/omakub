#!/bin/bash

# Install JetBrains Toolbox
# The toolbox provides a unified way to install and manage all JetBrains IDEs

# Install libfuse2t64 dependency (required for AppImage on Ubuntu 24.04)
sudo apt install -y libfuse2t64

# Download latest JetBrains Toolbox
cd /tmp
wget -O jetbrains-toolbox.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-latest.tar.gz"

# Extract and install
tar -xzf jetbrains-toolbox.tar.gz
TOOLBOX_DIR=$(find . -maxdepth 1 -type d -name 'jetbrains-toolbox-*' | head -n1)

if [ -d "$TOOLBOX_DIR" ]; then
  mkdir -p ~/.local/share/JetBrains/Toolbox
  cp "$TOOLBOX_DIR/jetbrains-toolbox" ~/.local/share/JetBrains/Toolbox/
  
  # Make executable
  chmod +x ~/.local/share/JetBrains/Toolbox/jetbrains-toolbox
  
  # Create desktop entry
  mkdir -p ~/.local/share/applications
  cat > ~/.local/share/applications/jetbrains-toolbox.desktop << 'EOF'
[Desktop Entry]
Name=JetBrains Toolbox
Exec=/home/$USER/.local/share/JetBrains/Toolbox/jetbrains-toolbox
Icon=jetbrains-toolbox
Type=Application
Categories=Development;IDE;
EOF
  
  # Launch toolbox (it will set itself up)
  nohup ~/.local/share/JetBrains/Toolbox/jetbrains-toolbox > /dev/null 2>&1 &
  
  echo "✓ JetBrains Toolbox installed successfully!"
  echo "  The toolbox window should open shortly."
  echo "  Use it to install IDEs like IntelliJ IDEA, PyCharm, WebStorm, etc."
else
  echo "✗ Failed to extract JetBrains Toolbox"
fi

# Cleanup
rm -rf jetbrains-toolbox.tar.gz "$TOOLBOX_DIR"
cd -
