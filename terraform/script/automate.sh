#!/bin/bash
sudo yum update -y
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
sudo apt-get update -y
sudo snap install aws-cli --classic -y 

# Install required packages for Docker installation
echo "Installing required packages..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker's official APT repository
echo "Adding Docker's official APT repository..."
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker service and enable it
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="1.29.2"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo "Applying executable permissions to the Docker Compose binary..."
sudo chmod +x /usr/local/bin/docker-compose

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 426857564226.dkr.ecr.us-east-1.amazonaws.com
docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend
docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend

cd ~
echo "version: '3'
services:
  frontend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend
    ports:
      - "8080:80"
  backend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend
    ports:
      - "8081:80"
" > docker-compose.yml
docker-compose up --build -d