#!/bin/bash
PROJECTNAME="$1"
DOMAIN="$2"

if [ -z "$PROJECTNAME" ]; then
    exit
fi

if [ -z "$DOMAIN" ]; then
    DOMAIN=$PROJECTNAME
fi

echo "Creating www project: \"$PROJECTNAME\" with domain \"$DOMAIN\""

if [ ! -d "/var/www/$PROJECTNAME" ]; then
	mkdir /var/www/$PROJECTNAME
	mkdir /var/www/$PROJECTNAME/public_html
	#todo: remove later:
	echo "$DOMAIN" > /var/www/$PROJECTNAME/public_html/index.html
	chown www-data:www-data -R /var/www/$PROJECTNAME
	mkdir /var/www/$PROJECTNAME/log
	touch /var/www/$PROJECTNAME/public_html/.keep
fi

