#!/bin/bash

PROJECTNAME="$1"
PROJECTPASS="$2"

if [ -z "$PROJECTNAME" ]; then read -p "Project name (max. 16 chr): " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi
if [[ ${#PROJECTNAME} -gt 16 ]]; then echo "Project name is too long."; exit; fi

if [ -z "$PROJECTPASS" ]; then read -p "Project password: " PROJECTPASS; fi
echo ""

RUNTIME="no"
# read -e -p "Runtime (no, php, nodejs): " -i ${RUNTIME} RUNTIME

DOCROOT="public_html"
if [ "nodejs" == $RUNTIME ]; then
    DOCROOT="public"
else
    echo "Docroot folder: $DOCROOT"
fi

DOMAIN=$PROJECTNAME
#read -e -p "Domain: " -i ${DOMAIN} DOMAIN

echo ""

echo "Create project: $PROJECTNAME"

./create-www_project.sh $PROJECTNAME $DOCROOT $RUNTIME
./create-www_reg_projectvhost.sh $PROJECTNAME $DOCROOT $DOMAIN $RUNTIME
./create-mysql_projectdb.sh $PROJECTNAME $PROJECTPASS
#./create-psql_projectdb.sh $PROJECTNAME $PROJECTPASS
#./create-ftp_project_user.sh $PROJECTNAME $PROJECTPASS
#./create-git_project.sh $PROJECTNAME
