#!/bin/bash

PROJECTNAME="$1"

if [ -z "$PROJECTNAME" ]; then
    exit
fi

echo "create svn project: $PROJECTNAME"
if [ ! -d "/srv/svn/repository/$PROJECTNAME" ]; then
    cd /var/www
    sudo -u www-data svnadmin create /srv/svn/repository/$PROJECTNAME
    sudo -u www-data svn import /srv/svn/svnlayout file:///srv/svn/repository/$PROJECTNAME/ --message 'Init structure'

    cat >/srv/svn/repository/$PROJECTNAME/hooks/post-commit <<EOL
#!/bin/sh
REPOS="\$1"
REV="\$2"
/srv/svn/svn-commit.sh "\$REPOS" "\$REV" "$PROJECTNAME"
EOL

    chmod +x /srv/svn/repository/$PROJECTNAME/hooks/post-commit
    chown www-data:www-data -R /srv/svn/repository/$PROJECTNAME
fi
