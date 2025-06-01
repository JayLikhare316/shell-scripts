# only for Ubuntu
#!/bin/bash
# For ARM64 / aarch64
sudo apt-get update
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb
sudo apt-get install -f
sudo dpkg -i amazon-q.deb
q --version
q login