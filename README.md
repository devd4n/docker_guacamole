# guacamole_docker

## Setup
wget https://github.com/devd4n/guacamole_docker.git
chmod +x guacamole_setup.sh
./guacamole_setup.sh

## Start Docker for test
docker-compose up
docker-compose down
  
## Start Docker finaly
-> finaly run docker-compose file in deamonized mode -> start on startup and in background
docker-compose up -d
  
## Update user-mappings file for User and Session Settings
docker-compose down
change File /srv/guacamole/user-mappings.xml
docker-compose up -d
