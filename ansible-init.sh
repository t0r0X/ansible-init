#!/usr/bin/env bash

help () {
	usage="$(basename "$0") project_dir [role [role]*]"
	echo $usage
}
#Check to make sure path is set.
if [ -z "$1" ]
  then
    echo "Set project path, where you want new Ansible scaffolding."
    echo " "
    help
    exit
  else
    project_dir=$1
    shift
    # set roles if present
    if [ -e $project_dir ]; then
      echo "Project \"$project_dir\" already exists, please remove it first"
      exit
    fi
    tmpfolder=$(mktemp -d)
    extra_vars='"project_dir": "'$tmpfolder'"'
    role_vars=" "
    if [ $# -gt 0 ]; then
      role_vars=", \"roles\": ["
      for role in "$@"
        do
          role_vars+="\"$role\", "
      done
      role_vars+="]"
    fi
    ansible-playbook init.yml -i inventory --connection=local -e {"$extra_vars $role_vars}" && {
      mv $tmpfolder $project_dir;
      echo "You project is at" $project_dir;
      echo " ";
      rm -rf $tmpfolder
    }
fi

