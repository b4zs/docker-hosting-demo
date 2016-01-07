#!/bin/bash

PROJECTNAME="$1"

if [ -z "$PROJECTNAME" ]; then read -p "Project name: " PROJECTNAME; fi
if [ -z "$PROJECTNAME" ]; then exit; fi

echo "Creating git repo project: \"$PROJECTNAME\""

if [ ! -d "/home/git/$PROJECTNAME.git" ]; then
    sudo su git -c "create $PROJECTNAME.git"
    cat > /home/git/$PROJECTNAME.git/hooks/post-receive <<EOL
echo "Post receive hook: Updating website"
#Change to working git repository to pull changes from bare repository
cd /var/www/$PROJECTNAME || exit
unset GIT_DIR
git reset --hard HEAD
git pull origin master
EOL

    chmod +x /home/git/$PROJECTNAME.git/hooks/post-receive
fi

if [ ! -d "/var/www/$PROJECTNAME/.git" ]; then
    cd "/var/www/$PROJECTNAME"
    sudo -u git git init
    sudo -u git git remote add origin /home/git/$PROJECTNAME.git
    sudo -u git git add .
    sudo -u git git commit -m "init"
    sudo -u git git push origin master
fi
