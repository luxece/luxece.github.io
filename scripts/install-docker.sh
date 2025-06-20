#!/bin/bash

# Cập nhật hệ thống
apt update && apt upgrade -y

# Cài gói hỗ trợ HTTPS cho apt
apt install -y ca-certificates curl gnupg lsb-release

# Thêm kho Docker chính thức
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]  https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cài Docker Engine
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Chạy Docker không cần usermod -aG docker $USER
newgrp docker
