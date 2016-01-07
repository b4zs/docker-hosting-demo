#!/bin/bash

PROJECTNAME="$1"
PROJECTPASS="$2"

if [ -z "$PROJECTNAME" ]; then read -p "Project name: " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi

if [ -z "$PROJECTPASS" ]; then
    read -s -p "Database password: " PROJECTPASS
    echo ""
fi

if [ -z "$PROJECTPASS" ]; then exit; fi

echo "Creating psql database: \"$PROJECTNAME\" with same username"

psql -U postgres -c "CREATE ROLE $PROJECTNAME NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN ENCRYPTED PASSWORD '$PROJECTPASS'" template1
psql -U postgres -c "CREATE DATABASE $PROJECTNAME WITH OWNER=$PROJECTNAME" template1
psql -U postgres -c "REVOKE ALL ON DATABASE $PROJECTNAME FROM public" template1
psql -U postgres -l
