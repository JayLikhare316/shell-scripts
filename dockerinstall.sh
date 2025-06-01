#!/bin/bash
# For ARM64 / aarch64
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $USER
newgrp docker
