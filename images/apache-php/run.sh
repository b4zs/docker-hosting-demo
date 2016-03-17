#!/bin/bash

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini

sed -i "s/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=staff/" /etc/apache2/envvars

sed -i -e "s/cfg\['blowfish_secret'\] = ''/cfg['blowfish_secret'] = '`date | md5sum`'/" /var/www/phpmyadmin/config.inc.php

if [ -n "$VAGRANT_OSX_MODE" ];then
    usermod -u $DOCKER_USER_ID www-data
    groupmod -g $(($DOCKER_USER_GID + 10000)) $(getent group $DOCKER_USER_GID | cut -d: -f1)
    groupmod -g ${DOCKER_USER_GID} staff
else
    # Tweaks to give Apache/PHP write permissions to the app
    chown -R www-data:staff /var/www
    chown -R www-data:staff /app
fi

#configure phpmyadmin
echo "\$dbserver=\"mysql\";                     " >> /etc/phpmyadmin/config-db.php
echo "\$dbuser=\"admin\";    " >> /etc/phpmyadmin/config-db.php
echo "\$dbpass='$MYSQL_ENV_MYSQL_ADMIN_PASS';   " >> /etc/phpmyadmin/config-db.php

echo "\$cfg['Servers'][1]['user'] = \$dbuser;" >> /etc/phpmyadmin/config.inc.php
echo "\$cfg['Servers'][1]['password'] = \$dbpass;" >> /etc/phpmyadmin/config.inc.php
echo "\$cfg['Servers'][1]['auth_type'] = 'config';" >> /etc/phpmyadmin/config.inc.php



echo "======================================================================="
echo "Webserver url: http://`hostname -I`"
echo "======================================================================="

exec supervisord -n
