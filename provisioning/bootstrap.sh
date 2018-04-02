#!/bin/bash

set -o errexit

function installSoftwareBase {
  # Install software base
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y build-essential
  # Install Python packages
  sudo apt-get install -y python-pip
  sudo pip install --upgrade pip
}


echo "Provisioning the Server"

installSoftwareBase

echo "Server Successfully Provisioned"
