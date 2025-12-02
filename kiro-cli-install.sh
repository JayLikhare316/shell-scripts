#!/bin/bash
# Kiro CLI installer for Debian/Ubuntu and macOS

set -e

# Check for broken installation and fix
check_broken_install() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Checking for broken packages..."
        sudo apt-get install -f -y
        sudo dpkg --configure -a
    fi
}

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Installing Kiro CLI on Linux..."
    
    # Fix any broken installations first
    check_broken_install
    
    # Update package index
    sudo apt-get update
    
    # Install dependencies
    sudo apt-get install -y curl wget
    
    # Download and install Kiro CLI
    curl -fsSL https://kiro.aws.dev/install.sh | bash
    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing Kiro CLI on macOS..."
    
    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install Kiro CLI via Homebrew
    brew tap aws/tap
    brew install kiro-cli
    
else
    echo "Unsupported operating system"
    exit 1
fi

# Verify installation
echo "Verifying installation..."
if command -v kiro &> /dev/null; then
    echo "Kiro CLI installed successfully!"
    kiro --version
else
    echo "Installation failed - kiro command not found"
    exit 1
fi

echo "Installation complete!"
echo "Run 'kiro login' to authenticate"
echo "Then use 'kiro --help' to get started"
