#!/bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

sudo apt install python-software-properties -y

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt install nodejs -y
 
sudo apt-get install npm -y

sudo npm install -g pm2

sudo echo "127.0.0.1       app" >> /etc/hosts
hostnamectl set-hostname app

# seeding the database
node ~/app/app/seeds/seed.js

sudo echo "server {
	listen 80;

	server_name _;

	location / {
		proxy_pass http://localhost:3000;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection 'upgrade';
		proxy_set_header Host $host;
		proxy_cache_bypass $http_upgrade;
	}
}" | sudo tee /etc/nginx/sites-available/default
