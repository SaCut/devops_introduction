#!/bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

sudo apt install python-software-properties -y

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt install nodejs -y
 
sudo apt-get install npm -y

sudo npm install -g pm2

hostnamectl set-hostname app

# seeding the database
node ./app/app/seeds/seed.js
