#!/bin/bash

PROJECTNAME="$1"
PROJECTPASS="$2"
PROJECTDIR="$3"

if [ -z "$PROJECTNAME" ]; then read -p "Project name: " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi

if [ -z "$PROJECTDIR" ]; then PROJECTDIR="/var/www/$PROJECTNAME"; fi


echo "create-ftp_project_user: $PROJECTNAME"
if [ -z "$PROJECTPASS" ]; then
    pure-pw useradd $PROJECTNAME -u 33 -g 33 -d $PROJECTDIR -y 4 -m
else
    (echo $PROJECTPASS; echo $PROJECTPASS) | pure-pw useradd $PROJECTNAME -u 33 -g 33 -d $PROJECTDIR -y 4 -m
fi

