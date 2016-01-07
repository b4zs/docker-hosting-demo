#!/bin/bash

PROJECTNAME="$1"

if [ -z "$PROJECTNAME" ]; then read -p "Project name: " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi

sudo -u www-data svn checkout --username deploy --password mWBnn67Rwx --no-auth-cache --force http://svn.assist01.gblocal/$PROJECTNAME/trunk /var/www/$PROJECTNAME
