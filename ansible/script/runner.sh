#!/bin/bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 426857564226.dkr.ecr.us-east-1.amazonaws.com
docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend
docker pull 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend

cd ~
echo "version: '3'
services:
  frontend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend-aa2b47e-20240607054008
    ports:
      - "8080:80"
  backend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend-aa2b47e-20240607054008
    ports:
      - "8081:80"

  mysql:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:database-aa2b47e-20240607054008
    ports:
      - "33060:3306"
" > docker-compose.yml
docker-compose up --build -d