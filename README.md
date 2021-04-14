# DevOps week

### What is devops?

#### DevOps is a culture that everyone needs to adopt

- A collaboration of Development and Operations.
- A culture which promotes collaboration between the two teams to deploy code.
- A practice of development and operation engineers taking part together in the whole service lifecycle.
- An approach through which superior quality software can be developed quickly and with more reliability.
- An alignment of development and IT operations with better communication and collaboration.


#### Vagrant commands:
- `vagrant` lists all the commands

- `vagrant up` to spin up a virtual machine
- `vagrant destroy` to destroy the vm
- `vagrant reload` to destroy and recreate the machine
- `vagrant status` to check if and how many machines are running

- `vagrant halt` forcefully closes the vm
- `vagrant ssh` to use the vm's shell
- `vagrant suspend` shuts down the current vm
- `vagrant resume` resumes a suspended vm

#### Linux commands
* `apt-get install` - Package manager
* `mkdir` - Make folder
* `ls` - list files
* `nano` - text editor
* `touch` - makefile
* `cd ..` - up a dir
* `pwd`  - print working directory
* `mv` - move also used to rename
* `cp` - copy
* `rm` - remove
* `ll` - check permissions

- Variables:
* `env` prints all variables
* `printenv VARNAME` prints the value of a specific variable
* `VARNAME="var_value"` for creating a variable
* `unset VARNAME` deletes the variable
* `export VARNAME="var_value"` for creating environment variables
* `echo 'export VARNMAE="var_value"' >> ~/.profile`

#### spinning up a vm
- set up configuration code inside the `Vagrantfile` file
- we used the following code:
```
# install required plugins
required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure("2") do |config|

    config.vm.define "app" do |app|
        # creating a virtual machine ubuntu
        app.vm.box = "ubuntu/xenial64"

        # let's attach a private network with IP
        app.vm.network "private_network", ip: "192.168.10.100"
        app.hostsupdater.aliases = ["development.local"]
        
        # to transfer files/folders from our OS to VM vagrant has an option os synced_folder
        app.vm.synced_folder ".", "/home/vagrant/app"
        
        app.vm.provision "shell", path: "provision_app.sh"
    end

    config.vm.define "db" do |db|
        # creating a virtual machine ubuntu
        db.vm.box = "ubuntu/xenial64"

        # let's attach a private network with IP
        db.vm.network "forwarded_port", guest: 27017, host: 27017
        db.hostsupdater.aliases = ["database.local"]
        
        # to transfer files/folders from our OS to VM vagrant has an option os synced_folder
        db.vm.synced_folder ".", "/home/vagrant/db"
        
        db.vm.provision "shell", path: "provision_db.sh"        
    end
end
```

- The provision files referenced are used to start the machine with some commands already executed
- This was our code:
    * for the 'app' vm:
    ```
    #!/bin/bash

    export DEBIAN_FRONTEND=noninteractive

    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install nginx -y
    sudo apt-get install python-software-properties -y

    # node.js
    sudo apt-get install npm -y
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
    sudo sh -c "echo deb https://deb.nodesource.com/node_6.x xenial main \> /etc/apt/sources.list.d/nodesource.list"
    sudo apt-get update -y
    sudo apt-get install -y nodejs
    sudo npm install -g pm2
    ```
    * for the 'db' vm:
    ```
    #!/bin/bash

    export DEBIAN_FRONTEND=noninteractive

    # update and upgrade
    sudo apt-get update -y
    sudo apt-get upgrade -y

    # mongo-db
    wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

    sudo mkdir -p /data/db
    sudo chown -R mongodb:mongodb /var/lib/mongodb
    sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
    sudo systemctl enable mongod
    sudo service mongod start
    ```