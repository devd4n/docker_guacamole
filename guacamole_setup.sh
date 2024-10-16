#!/bin/bash
DOCKER_COMPOSE_VERSION="2.29.6"
PATH_POSTGRES_JDBC="https://jdbc.postgresql.org/download/postgresql-42.7.4.jar"
NAME_POSTGRES_JDBC="postgresql-42.7.4.jar"
OS=$(cat /etc/os-release | grep ^ID= | sed 's/ID=//g')

echo "OS found: $OS"

sudo apt-get update
sudo apt-get install docker

# Set up the repository
# Update the apt package index and install packages to allow apt to use a repository over HTTPS:

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key: (--yes for auto overide all old files)
curl -fsSL https://download.docker.com/linux/$OS/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$OS $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

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

#mkdir -p ./postgresql
#wget -O ./$NAME_POSTGRES_JDBC $PATH_POSTGRES_JDBC
#mv ./$NAME_POSTGRES_JDBC ./postgresql/
#wget -O ./guacamole-auth-jdbc-1.5.5.tar.gz https://dlcdn.apache.org/guacamole/1.5.5/binary/guacamole-auth-jdbc-1.5.5.tar.gz
#tar xvfz ./guacamole-auth-jdbc-1.5.5.tar.gz
#mv ./guacamole-auth-jdbc-1.5.5/postgresql/* ./postgresql/
#rm -r ./guacamole-auth-jdbc-1.5.5

mkdir -p ./init
sudo docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgresql > ./init/initdb.sql
