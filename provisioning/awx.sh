#!/bin/bash

set -o errexit

POSTGRES_DATA_DIR=/opt/pgdocker

function installSoftwareBase {
  sudo pip install docker-py
}

function installAWX {
  git clone https://github.com/ansible/awx
  git clone https://github.com/ansible/awx-logos
  sudo chown -R vagrant:vagrant awx
  sudo chown -R vagrant:vagrant awx-logos
}

function setupAWX {
  # Configure the PostgreSQL folder
  sudo mkdir $POSTGRES_DATA_DIR
  sudo sed -i -e"s|postgres_data_dir=/tmp/pgdocker|postgres_data_dir=$POSTGRES_DATA_DIR|g" awx/installer/inventory
  # Run the server
  pushd ./awx/installer
  ansible-playbook -i inventory install.yml
  popd
}

echo "Setup Ansible AWX"

installSoftwareBase
installAWX
setupAWX

echo "Ansible AWX setup complete"
