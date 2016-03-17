FROM phusion/baseimage:latest
MAINTAINER Balazs Varga <b4zs@b4zs.com>

# based on dgraziotin/osx-docker-lamp
# MAINTAINER Daniel Graziotin <daniel@ineed.coffee>

ENV DOCKER_USER_ID 501 
ENV DOCKER_USER_GID 20

ENV BOOT2DOCKER_ID 1000
ENV BOOT2DOCKER_GID 50

# Tweaks to give Apache/PHP write permissions to the app
RUN usermod -u ${BOOT2DOCKER_ID} www-data && \
    usermod -G staff www-data 

RUN groupmod -g $(($BOOT2DOCKER_GID + 10000)) $(getent group $BOOT2DOCKER_GID | cut -d: -f1)
RUN groupmod -g ${BOOT2DOCKER_GID} staff

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install \
      supervisor wget git apache2 libapache2-mod-php5 \
      php5-mysql php5-curl php5-xdebug php5-intl php5-gd php5-imagick php5-mcrypt php-apc php5-mcrypt \
      zip unzip phpmyadmin  && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf



# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh && chmod 644 /etc/phpmyadmin/config-db.php
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
RUN php5enmod mcrypt

# configure php/xdebug/opcache
RUN echo 'xdebug.remote_enable=1 \n\
xdebug.remote_host=host \n\
xdebug.remote_port="9000" \n\
xdebug.remote_connect_back=1 \n\
xdebug.idekey="PHPSTORM" \n\
xdebug.profiler_enable=0 \n\
xdebug.profiler_output_dir="/tmp/profiler/" \n\
xdebug.max_nesting_level=300 \n\
xdebug.var_display_max_depth=4 ' >> /etc/php5/mods-available/xdebug.ini
RUN echo 'display_startup_errors = On\ndisplay_errors = On' >> /etc/php5/apache2/php.ini

# install composer
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php --install-dir=bin --filename=composer && \
    rm composer-setup.php

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www && ln -s /app /var/www

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 100M
ENV PHP_POST_MAX_SIZE 10M

EXPOSE 80
CMD ["/run.sh"]