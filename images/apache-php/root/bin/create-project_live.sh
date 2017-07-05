#!/bin/bash

PROJECTNAME="$1"
DOMAIN="$2"

if [ -z "$PROJECTNAME" ]; then
    exit
fi

echo "Create project: $PROJECTNAME"
/root/create-www_project.sh $PROJECTNAME $DOMAIN
/root/create-www_reg_projectvhost.sh $PROJECTNAME $DOMAIN
/root/create-ftp_project_user.sh $PROJECTNAME
/root/create-mysql_projectdb.sh $PROJECTNAME
