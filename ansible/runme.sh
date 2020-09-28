#!/bin/bash

python3 -m venv ~/venv-ansible --system-site-packages
source ~/venv-ansible/bin/activate
pip install ansible
git clone https://github.com/JohnGarbutt/arcus-terraform-idrac
cd arcus-terraform-idrac/ansible
ansible-playbook mft.yml
