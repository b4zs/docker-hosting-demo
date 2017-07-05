#!/bin/bash

PROJECTNAME="$1"
DOMAIN="$2"

if [ -z "$PROJECTNAME" ]; then
    exit
fi

if [ -z "$DOMAIN" ]; then
    DOMAIN=$PROJECTNAME
fi

echo "create www project vhost: $PROJECTNAME"

if [ ! -f "/etc/apache2/sites-available/$PROJECTNAME" ]; then
	echo "Use 8waysOnlyProjectVhost \"$PROJECTNAME\" \"$DOMAIN\" \" \"" > /etc/apache2/sites-available/$PROJECTNAME
fi

echo "activate vhost: $PROJECTNAME"

if [ ! -h "/etc/apache2/sites-enabled/100-$PROJECTNAME" ]; then
	ln -s /etc/apache2/sites-available/$PROJECTNAME /etc/apache2/sites-enabled/100-$PROJECTNAME
	CHECKCONF=`apache2ctl -t 2>&1`
	if [ "$CHECKCONF" = "Syntax OK" ]; then
		/etc/init.d/apache2 reload
	else
		echo "Apache config check error: "
		echo "$CHECKCONF"
	fi
fi

