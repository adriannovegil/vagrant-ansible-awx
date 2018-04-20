#!/bin/bash

set -o errexit

function installSoftwareBase {
  # Install software base
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
}

function installDocker {
  # Install key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  # Add Docker repository
  sudo add-apt-repository -y \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
  # Update
  sudo apt-get update
  # Install Docker
  sudo apt-get install -y docker-ce
  sudo usermod -aG docker vagrant
  # Restarting Docker
  sudo systemctl stop docker
  sudo systemctl daemon-reload
  sudo systemctl start docker
  # Make sure it starts at every server reboot
  sudo systemctl enable docker
  sudo systemctl restart docker
}

function installDockerCompose {
  # Install compose
  sudo cp /vagrant/contrib/docker-compose/docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

echo "Setup Docker"

installSoftwareBase
installDocker
installDockerCompose

echo "Docker setup complete"
