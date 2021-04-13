#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

sudo apt-get install python-software-properties -y
 
sudo apt-get install npm -y

curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

sudo sh -c "echo deb https://deb.nodesource.com/node_6.x xenial main \> /etc/apt/sources.list.d/nodesource.list"

sudo apt-get update -y

sudo apt-get install -y nodejs

sudo npm install -g pm2
