#!/bin/bash
# Gemini CLI installer for Ubuntu and macOS

set -e

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Installing on Linux..."
    # Update package index
    sudo apt update
    # Install curl and Node.js 20
    sudo apt install -y curl
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing on macOS..."
    # Install Node.js via Homebrew
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install node@20
    brew link node@20 --force
else
    echo "Unsupported OS"
    exit 1
fi

# Check Node.js version (must be 20+)
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 20 ]; then
    echo "Error: Node.js version 20+ required. Current version: $(node -v)"
    exit 1
fi

echo "Node.js version: $(node -v) ✓"
echo "npm version: $(npm -v)"

# Install Gemini CLI
npm install -g @google/gemini-cli

# Get API key from user
echo "Please enter your Gemini API key:"
read -r API_KEY

# Create .env file
echo "Creating .env file in home directory..."
cat > ~/.env << EOF
GEMINI_API_KEY="$API_KEY"
EOF

echo "Installation complete!"
echo "Run: gemini"