#!/bin/bash

PROJECT="$1"
PROJECTDIR="$2"

if [ -z "$PROJECT" ]; then
    echo "No project name"
    exit
fi

if [ -z "$PROJECTDIR" ]; then
    PROJECTDIR="/var/www/$PROJECT"
fi

echo "create-ftp_project_user: $PROJECT"
pure-pw useradd $PROJECT -u 33 -g 33 -d $PROJECTDIR -y 4 -m
