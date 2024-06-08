#!/bin/bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 426857564226.dkr.ecr.us-east-1.amazonaws.com
mkdir -p ~/data/db/mysql
cp ~/ansible/init.sql ~/data/db/mysql

cd ~
echo "version: '3'
services:
  frontend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:frontend-4745ae7-20240608074058
    ports:
      - 8080:80
    depends_on:
      - backend
  backend:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:backend-4745ae7-20240608074058
    ports:
      - 8081:80
    depends_on:
      - mysql-test
  mysql-test:
    image: 426857564226.dkr.ecr.us-east-1.amazonaws.com/testujwal001:database-4745ae7-20240608074058
    ports:
      - 33060:3306
    environment:
      - MYSQL_DATABASE=test_db
      - MYSQL_ROOT_PASSWORD=ujwal1234
      - MYSQL_USER=ujwal
      - MYSQL_PASSWORD=ujwal1234
    volumes:
      - ~/data/db/mysql/init.sql:/docker-entrypoint-initdb.d/init.sql " > ~/docker-compose.yml
docker-compose up --build -d
