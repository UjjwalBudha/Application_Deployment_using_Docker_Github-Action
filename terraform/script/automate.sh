#!/bin/bash
sudo yum update -y
sudo yum install git -y
sudo amazon-linux-extras install epel -y
sudo yum install ansible -y
cd ~
aws s3 sync s3://amazon-linux-ansible-code-ujwal/ ~/ansible/
cd ~/ansible
ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml