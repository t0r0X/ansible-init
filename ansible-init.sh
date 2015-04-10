#!/usr/bin/env bash

#Check to make sure path is set.
if [ -z "$1" ]
  then
    echo "Set project path, where you want new Ansible scaffolding."
    echo " "
    exit
  else
    ansible-playbook init.yml -i production --connection=local --extra-vars='{"roles": ["web", "database"], "project_dir": "/tmp/foo_project" }'
    mv /tmp/foo_project $1
    echo "You project is at" $1 
    ls -l $1
    echo " "
fi
