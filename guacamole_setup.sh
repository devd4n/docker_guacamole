#!/bin/bash
DOCKER_COMPOSE_VERSION="1.29.2"

sudo apt-get update
sudo apt-get install docker

# Set up the repository
# Update the apt package index and install packages to allow apt to use a repository over HTTPS:

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key: (--yes for auto overide all old files)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
# Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version:
sudo apt-get update
sudo apt-get --yes install docker-ce docker-ce-cli containerd.io

# install docker-compose https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "Docker-Compose-Version:"
docker-compose --version

mkdir -p ./srv/guacamole
echo "Enter password for Postgress-Container:"
read -s password
echo "DOCKER_GUACAMOLE_POSTGRES_PWD=$password" > ./.env

mkdir -p ./init
sudo docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./init/initdb.sql

mkdir -p ./postgresql
wget -O ./postgresql/postgresql-42.3.3.jar https://jdbc.postgresql.org/download/postgresql-42.3.3.jar 
wget -O ./guacamole-auth-jdbc-1.4.0.tar.gz https://apache.org/dyn/closer.lua/guacamole/1.4.0/binary/guacamole-auth-jdbc-1.4.0.tar.gz?action=download
tar xvfz ./guacamole-auth-jdbc-1.4.0.tar.gz
cp ./guacamole-auth-jdbc-1.4.0/sqlserver/guacamole-auth-jdbc-sqlserver-1.4.0.jar ./postgresql/
rm -r./guacamole-auth-jdbc-1.4.0
