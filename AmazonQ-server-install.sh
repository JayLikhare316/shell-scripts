#!/bin/bash
# Amazon Q CLI installer for multiple server platforms

set -e

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

echo "Detected OS: $OS, Architecture: $ARCH"

# Install Amazon Q based on platform
if [[ "$OS" == "linux" ]]; then
    # Detect Linux distribution
    if command -v apt-get &> /dev/null; then
        echo "Installing on Debian/Ubuntu..."
        sudo apt-get update
        wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb
        sudo apt-get install -f -y
        sudo dpkg -i amazon-q.deb
        rm amazon-q.deb
    elif command -v yum &> /dev/null; then
        echo "Installing on RHEL/CentOS/Amazon Linux..."
        sudo yum update -y
        wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.rpm
        sudo yum install -y amazon-q.rpm
        rm amazon-q.rpm
    elif command -v dnf &> /dev/null; then
        echo "Installing on Fedora..."
        sudo dnf update -y
        wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.rpm
        sudo dnf install -y amazon-q.rpm
        rm amazon-q.rpm
    else
        echo "Unsupported Linux distribution"
        exit 1
    fi
elif [[ "$OS" == "darwin" ]]; then
    echo "Installing on macOS..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install --cask amazon-q
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# Verify installation
echo "Verifying installation..."
q --version

echo "Installation complete!"
echo "Run 'q login' to authenticate with Amazon Q"
