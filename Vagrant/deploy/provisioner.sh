#!/bin/bash
##############################################################
# This file creates the environment on a linux machine for our app
###############################################################

yum_filename="/tmp/deploy/yum-pkgs.txt"
app_dir="/opt/home_app"
app_group="homers"
app_name="home_app"
app_user="home"

function create_group {
	 if [ $(getent group $app_group) ]; then
		 echo "$app_group already exists."
	 else
		 groupadd $app_group
		 echo "$app_group has been created."
	 fi
}


function create_svc_user {
    if [ $(getent passwd $app_user) ]; then
	    echo "$app_user already exists."
	  else
	     useradd -r $app_user
	    echo "$app_user has been created."
	    fi
}


function dirapp_setup {
	test -d $app_dir && echo "Directory exists" || (mkdir $app_dir; echo "Created Directory $app_dir") 
	test -d /tmp/deploy/${app_name}/ && cp -avr /tmp/deploy/${app_name}/* ${app_dir} || (echo "Application is not found"; exit 1)
	chown -R $app_user:$app_group $app_dir
}

function main {
    test -e $yum_filename && yum -y install $(cat $yum_filename) || (echo " $yum_filename is not found, can't continue"; exit 1)
    create_group -a -G $app_group $app_user 
    create_svc_user $app_user 
    usermod -a -G $app_group $app_user
    dirapp_setup
}

main
