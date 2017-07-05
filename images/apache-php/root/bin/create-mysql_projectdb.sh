#!/bin/bash

PROJECT="$1"
PROJECTPASS="$2"

if [ -z "$PROJECT" ]; then
    echo "No project name"
        exit
    fi

if [ -z "$PROJECTPASS" ]; then
    read -s -p "Project password: " PROJECTPASS
    echo ""
fi

mysql -h mysql -u root -pexample  -e "CREATE USER '$PROJECT'@'%' IDENTIFIED BY '$PROJECTPASS';"
mysql -h mysql -u root -pexample  -e "GRANT USAGE ON * . * TO '$PROJECT'@'%' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;"
mysql -h mysql -u root -pexample  -e "CREATE DATABASE IF NOT EXISTS \`$PROJECT\` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -h mysql -u root -pexample  -e "GRANT ALL PRIVILEGES ON \`$PROJECT\` . * TO '$PROJECT'@'%';"
mysql -h mysql -u root -pexample  -e "GRANT ALL PRIVILEGES ON \`$PROJECT\_%\` . * TO '$PROJECT'@'%';"

mysql -h mysql -u root -pexample  -e "show databases;"
