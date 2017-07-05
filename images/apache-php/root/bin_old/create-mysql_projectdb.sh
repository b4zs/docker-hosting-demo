#!/bin/bash

PROJECTNAME="$1"
PROJECTPASS="$2"

if [ -z "$PROJECTNAME" ]; then read -p "Project name (max. 16 chr): " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi
if [[ ${#PROJECTNAME} -gt 16 ]]; then echo "Project name is too long."; exit; fi

if [ -z "$PROJECTPASS" ]; then
    read -s -p "Database password: " PROJECTPASS
    echo ""
fi

if [ -z "$PROJECTPASS" ]; then exit; fi

echo "Creating mysql database: \"$PROJECTNAME\" with same username"

mysql -h mysql -u root -pexample -e "CREATE USER '$PROJECTNAME'@'localhost' IDENTIFIED BY '$PROJECTPASS';"
mysql -h mysql  -u root -pexample -e "GRANT USAGE ON *.* TO '$PROJECTNAME'@'localhost' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;"
mysql -h mysql  -u root -pexample -e "CREATE DATABASE IF NOT EXISTS \`$PROJECTNAME\` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -h mysql  -u root -pexample -e "GRANT ALL PRIVILEGES ON \`$PROJECTNAME\`.* TO '$PROJECTNAME'@'localhost';"
mysql -h mysql  -u root -pexample -e "GRANT ALL PRIVILEGES ON \`$PROJECTNAME\_%\`.* TO '$PROJECTNAME'@'localhost';"

mysql  -u root -pexample -e "show databases;"
