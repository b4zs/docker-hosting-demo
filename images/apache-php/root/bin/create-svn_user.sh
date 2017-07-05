#!/bin/bash

USERNAME="$1"

if [ -z "$USERNAME" ]; then
    echo "No username"
    exit
fi

htpasswd -s /etc/apache2/dav_svn.passwd $USERNAME
