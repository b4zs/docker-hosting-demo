#!/bin/bash

PROJECTNAME="$1"
DOCROOT="$2"
DOMAIN="$3"
RUNTIME="$4"

if [ -z "$PROJECTNAME" ]; then read -p "Project name: " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi

if [ -z "$RUNTIME" ]; then RUNTIME="php"; fi
if [ -z "$DOCROOT" ]; then DOCROOT="public_html"; fi

if [ -z "$DOMAIN" ]; then DOMAIN=$PROJECTNAME; fi

echo "Creating www project vhost: \"$PROJECTNAME\" with domain \"$DOMAIN\", runtime: \"$RUNTIME\""

if [ ! -f "/etc/apache2/sites-available/$PROJECTNAME" ]; then
    if [ "php" == $RUNTIME ]; then
        echo "Use VhostPHPPool \"www\" \"$PROJECTNAME\" \"$DOCROOT\" \"$DOMAIN\" \" \"" >> /etc/apache2/sites-available/$PROJECTNAME
    elif [ "nodejs" == $RUNTIME ]; then
        echo "Use NodejsVhost \"$PROJECTNAME\" \"$DOCROOT\" \"$DOMAIN\" \" \"" >> /etc/apache2/sites-available/$PROJECTNAME
    else
        echo "Use SimpleVhost \"$PROJECTNAME\" \"$DOCROOT\" \"$DOMAIN\" \" \"" >> /etc/apache2/sites-available/$PROJECTNAME
    fi
fi

echo "activate vhost: \"$PROJECTNAME\""

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
