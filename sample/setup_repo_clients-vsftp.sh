#!/bin/bash

#Remove repositories 
ansible all -m file -a "path=/etc/yum.repos.d/redhat.repo state=absent"

#Include control.example.com to /etc/hosts
ansible all -m lineinfile -a 'dest=/etc/hosts line="192.168.122.11 control control.example.com"'

#List current enabled repositories
#ansible all -m shell -a 'subscription-manager repos --list-enabled | grep "Repo ID:"'

#Disable repositories
ansible all -m shell -a 'subscription-manager repos --disable rhel-8-for-x86_64-baseos-rpms --disable rhel-8-for-x86_64-appstream-rpms'

#Create BaseOS and AppStream repositories
ansible all -m yum_repository -a "description=baseos file=baseos name=baseos baseurl=ftp://control.example.com/ enabled=1 gpgcheck=0"
ansible all -m yum_repository -a "description=appstream file=appstream name=appstream baseurl=ftp://control.example.com/ enabled=1 gpgcheck=0"
