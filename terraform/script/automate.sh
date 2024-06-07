#!/bin/bash
sudo apt update -y
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
sudo apt-get update -y
sudo snap install aws-cli --classic

# Update the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Git
sudo apt-get install git -y

# Add Ansible PPA and install Ansible
sudo apt-get install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y

# Install AWS CLI if not already installed
sudo apt-get install awscli -y


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

# Sync files from the S3 bucket to the local machine
aws s3 sync s3://intern-ujwal-docker/ ~/ansible/

# Change directory to the ansible directory
cd ~/ansible

# Run the Ansible playbook locally
ansible-playbook --connection=local --inventory localhost, playbook.yml

# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 426857564226.dkr.ecr.us-east-1.amazonaws.com
# docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend
# docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend

# cd ~
# echo "version: '3'
# services:
#   frontend:
#     image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend
#     ports:
#       - "8080:80"
#   backend:
#     image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend
#     ports:
#       - "8081:80"
# " > docker-compose.yml
# docker-compose up --build -d