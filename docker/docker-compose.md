# docker installation#
sudo apt update

sudo apt install docker.io -y

# docker compose manual installation#

sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose


sudo chmod +x /usr/local/bin/docker-compose


docker-compose --version

