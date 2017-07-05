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
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get -y --allow-unauthenticated install \
      supervisor wget git apache2 libapache2-mod-php7.1 \
      php7.1-soap php7.1-mcrypt \
      php7.1-mysql php7.1-curl php7.1-xdebug php7.1-intl php7.1-gd php7.1-imagick php7.1-mcrypt \
      zip unzip phpmyadmin  && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN echo 'root:root' | chpasswd
RUN apt-get -y install openssh-server
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
ADD ssh/ssh_host* /etc/ssh/
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfnbIf6kbcyVMATlh9WCEcQt8IG9ZeQyVgwLWOMf9/MEDpn2LXFxfLwRdXm63KJRuN/TTCQeihcr3n5zPN2fLm39WnNCnTnot45+z7Pgjft/v6w6wmcS8MShe9LZzJxBFOI+RYGBgxsnjyk+fEM3jQvsSdzEoAf31Jhjsbe+hMx9pyKbQfg3i6oynZXvrOINH5WS4dbd/WIR1ZgFO/qhdQYydDIZ/2vWNVivK5OJo59Ce3rdiFn5aZ5v15f0+8UNFGakLCqUQ9T4Glwl0FRr87kyg8Q4kgeaPmDt6wcFlZHWE+mJHIMio0p+XNK5hOiCG/tIReXGr77A0t5ZivwZhR b4zs@b4zs-mbp.local' >> /root/.ssh/authorized_keys


RUN apt-get -y install iputils-ping dnsutils


ADD root/bin root/bin
RUN chmod +x /root/bin/*
# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
ADD apache_macros.conf /etc/apache2/conf-enabled/apache_macros.conf
RUN a2enmod rewrite
RUN a2enmod macro
RUN phpenmod mcrypt

# configure php/xdebug/opcache
RUN echo 'xdebug.remote_enable=1 \n\
xdebug.remote_host=172.17.0.1 \n\
xdebug.remote_port="9000" \n\
xdebug.remote_connect_back=1 \n\
xdebug.idekey="PHPSTORM" \n\
xdebug.profiler_enable=0 \n\
xdebug.profiler_output_dir="/tmp/profiler/" \n\
xdebug.max_nesting_level=300 \n\
xdebug.var_display_max_depth=4 ' >> /etc/php/7.1/mods-available/xdebug.ini
RUN echo 'display_startup_errors = On\ndisplay_errors = On\ndate.timezone=Europe/Budapest' >> /etc/php/7.1/apache2/php.ini
RUN echo 'display_startup_errors = On\ndisplay_errors = On\ndate.timezone=Europe/Budapest' >> /etc/php/7.1/cli/php.ini

# install composer
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php --install-dir=bin --filename=composer && \
    rm composer-setup.php

RUN mkdir /var/www/public_html

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh && chmod 644 /etc/phpmyadmin/config-db.php
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 100M
ENV PHP_POST_MAX_SIZE 10M
WORKDIR /var/www
EXPOSE 80
CMD ["/run.sh"]