#!/bin/bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 426857564226.dkr.ecr.us-east-1.amazonaws.com
docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend
docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend

cd ~
echo "version: '3'
services:
  frontend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend-b638d58-20240607050822
    ports:
      - "8080:80"
  backend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend-b638d58-20240607050822
    ports:
      - "8081:80"
" > docker-compose.yml
docker-compose up --build -d