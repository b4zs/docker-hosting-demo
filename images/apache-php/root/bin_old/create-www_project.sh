#!/bin/bash

PROJECTNAME="$1"
DOCROOT="$2"
RUNTIME="$3"

if [ -z "$PROJECTNAME" ]; then read -p "Project name: " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi

if [ -z "$RUNTIME" ]; then RUNTIME="php"; fi
if [ -z "$DOCROOT" ]; then DOCROOT="public_html"; fi

echo "Creating www project: \"$PROJECTNAME\" with docroot \"$DOCROOT\", runtime: \"$RUNTIME\""

if [ ! -d "/var/www/$PROJECTNAME" ]; then
        mkdir -p /var/www/$PROJECTNAME/$DOCROOT
        if [ "nodejs" == $RUNTIME ]; then
            mkdir -p /var/www/$PROJECTNAME/tmp
        fi
        chown www-data:www-data -R /var/www/$PROJECTNAME
        touch /var/www/$PROJECTNAME/$DOCROOT/.keep
fi
