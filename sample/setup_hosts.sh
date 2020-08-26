#!/bin/bash

#Ensure Python is present
ansible all -m yum -a "name=python3 state=present" -u root --ask-pass

#Ensure ansible is present
ansible all -m user -a "name=ansible state=present" -u root --ask-pass

#Change password to Ansible user in all nodes
ansible all -m shell -a "echo password | passwd ansible --stdin" -u root --ask-pass

#Create sudoers entry for user ansible
ansible all -m lineinfile -a 'create=yes dest=/etc/sudoers.d/ansible line="ansible ALL=(ALL) NOPASSWD: ALL"' -u root --ask-pass

#Copy SSH keys
ansible all -m authorized_key -a "user=ansible state=present key=\"{{ lookup(\'file\',\'/home/ansible/.ssh/id_rsa.pub\') }}\""

#Test connecvity using ping
ansible all -m ping
