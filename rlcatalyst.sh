#!/bin/bash
mongo_install() {
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
        echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
        sudo apt-get update
        sudo apt-get install -y mongodb-org
        sudo cp /tmp/mongo-db /etc/init.d/mongo-db
        sudo chmod +x /etc/init.d/mongo-db
        sudo mkdir -p /data/db
        sudo service mongo-db start
	sudo update-rc.d mongo-db defaults
}

nodejs_install() {
        cd /opt
        sudo wget https://nodejs.org/dist/v4.2.2/node-v4.2.2-linux-x64.tar.gz
        sudo tar zxvf node-v4.2.2-linux-x64.tar.gz
        sudo mv node-v4.2.2-linux-x64 node
        sudo ln -s /opt/node/bin/node /usr/bin/node
        sudo ln -s /opt/node/bin/npm /usr/bin/npm
        sudo npm install -g npm@3.4.0
        sudo npm install -g forever
        sudo ln -s /opt/node/bin/forever /usr/bin/forever
        sudo npm install -g kerberos
}

python_install() {
        cd ~
        sudo apt-get -y install build-essential
        sudo apt-get -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
        sudo wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tgz && tar -xvf Python-2.7.5.tgz && cd Python-2.7.5 && ./configure && make && make install
        sudo rm Python-2.7.5.tgz
}

catalystdeploy()
{
    #Install the Catalyst
    cd ~
    sudo git clone https://github.com/RLOpenCatalyst/core.git /opt/core
    sudo mv /opt/core /opt/rlcatalyst
    cd /opt/rlcatalyst/server
    sudo npm install
    sudo node install --seed-data
    sudo cp /tmp/rlcatalyst /etc/init.d/rlcatalyst
    sudo chmod +x /etc/init.d/rlcatalyst
    sudo mkdir -p /var/log/rlcatalyst
    sudo /etc/init.d/rlcatalyst start
    sudo update-rc.d rlcatalyst defaults
}

puppet() {
        sudo git clone https://github.com/RLOpenCatalyst/puppet-cookbook /opt/rlcatalyst/server/puppet-cookbook
}



#Install the dependencies
sudo apt-get update
sudo apt-get install -y g++ 
sudo apt-get install -y make 
sudo apt-get install -y libkrb5-dev 
sudo apt-get install -y curl 
sudo apt-get install -y git 
sudo apt-get install -y wget
sudo curl -L https://www.opscode.com/chef/install.sh | sudo bash
sudo /opt/chef/embedded/bin/gem install knife-windows


#Install the required packages
mongo_install
python_install
nodejs_install
catalystdeploy
puppet












