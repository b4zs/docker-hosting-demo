#!/bin/bash

PROJECTNAME="$1"

if [ -z "$PROJECTNAME" ]; then
    exit
fi

echo "checkout svn project: $PROJECTNAME"
if [ -d "/srv/svn/repository/$PROJECTNAME" ]; then
    cd /var/www
    sudo -u www-data svn checkout --force file:///srv/svn/repository/$PROJECTNAME/trunk /var/www/$PROJECTNAME"live"
fi
