#!/bin/bash

set -o errexit

function installAnsible {
	# Install repository
	sudo apt-add-repository -y ppa:ansible/ansible
	# update
	sudo apt-get update
	# Install Ansible
	sudo apt-get install -y ansible
}

echo "Setup Ansible"

installAnsible

echo "Ansible setup complete"
