PROJECTNAME="$1"
REPOURL="$2"

if [ -z "$PROJECTNAME" ]; then
    read -p "Project name: " PROJECTNAME
    echo ""
fi

if [ -z "$REPOURL" ]; then
    read -p "Repository url: " REPOURL
    echo ""
fi

if [ "" != "$REPOURL" ]; then
    mkdir /var/www/$PROJECTNAME/deploy
    git clone $REPOURL /var/www/$PROJECTNAME/deploy/
    rm /var/www/$PROJECTNAME/public_html/.keep
    shopt -s dotglob && chown www-data:www-data /var/www/$PROJECTNAME/deploy -R && mv /var/www/$PROJECTNAME/deploy/* /var/www/$PROJECTNAME/public_html/ && rmdir /var/www/$PROJECTNAME/deploy
    touch /var/www/$PROJECTNAME/public_html/.keep
    cp /root/deploy.php /var/www/$PROJECTNAME/public_html/
fi


