# guacamole_docker

## Setup
sudo apt-get install git  
git clone https://github.com/devd4n/guacamole_docker.git  
cd guacamole_docker  
chmod +x guacamole_setup.sh  
./guacamole_setup.sh  

## Start Docker for test
docker-compose up  
-> Test the instance  
ctrl + c  
  
## Start Docker finaly
-> finaly run docker-compose file in deamonized mode -> start on startup and in background  
docker-compose up -d  
  
## Update packages and postgresql
... under development  

## TSHOOT - Postgres Docker
ssh -i .ssh/... root@...

docker exec -it --user root <<container-id>> /bin/bash
apt update
apt install postgresql-client
psql -U guacamole_user -p 5432 -h postgres guacamole_db
\dt
