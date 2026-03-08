# install docker#

sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# remove the sudo #
sudo usermod -aG docker ubuntu

newgrp docker

**✅ Step 2: Allow Docker to Access X Server (For GUI)**
**not for server machine**


xhost +local:docker