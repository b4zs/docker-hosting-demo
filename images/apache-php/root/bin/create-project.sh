#!/bin/bash

PROJECTNAME="$1"
DOMAIN="$2"

if [ -z "$PROJECTNAME" ]; then
    read -p "Project name: " PROJECTNAME
    echo ""
fi

if [ -z "$PROJECTNAME" ]; then
    exit
fi

echo "Create project: $PROJECTNAME"
/root/bin/create-www_project.sh $PROJECTNAME $DOMAIN
#/root/bin/create-svn_project.sh $PROJECTNAME
/root/bin/create-www_reg_projectvhost.sh $PROJECTNAME $DOMAIN
#/root/bin/create-ftp_project_user.sh $PROJECTNAME
/root/bin/create-mysql_projectdb.sh $PROJECTNAME
