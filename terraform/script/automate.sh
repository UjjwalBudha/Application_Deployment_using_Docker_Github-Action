#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update the system
echo "Updating the system..."
sudo apt-get update -y

# Install essential tools
echo "Installing essential tools..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    git

# Install AWS CLI
echo "Installing AWS CLI..."
sudo snap install aws-cli --classic

# Add Ansible PPA and install Ansible
echo "Adding Ansible PPA and installing Ansible..."
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

# Add Docker's official GPG key and APT repository
echo "Adding Docker's official GPG key and APT repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker service and enable it
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install Docker Compose
DOCKER_COMPOSE_VERSION="1.29.2"
echo "Installing Docker Compose version ${DOCKER_COMPOSE_VERSION}..."
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo "Applying executable permissions to the Docker Compose binary..."
sudo chmod +x /usr/local/bin/docker-compose

# # Sync files from the S3 bucket to the local machine
# echo "Syncing files from S3 bucket..."
# aws s3 sync s3://intern-ujwal-docker/ ~/ansible/

# # Install Ansible Galaxy collection for Docker
# echo "Installing Ansible Galaxy collection for Docker..."
# ansible-galaxy collection install community.docker

# # Change directory to the ansible directory
# cd ~/ansible

# # Run the Ansible playbook locally
# echo "Running the Ansible playbook..."
# ansible-playbook --connection=local --inventory localhost, playbook.ymlls
