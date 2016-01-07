FROM ubuntu:latest
MAINTAINER b4zs@b4zs.com

RUN apt-get update && apt-get install -y openssh-server apache2 supervisor php5 mysql-server curl php5-mysql php5-curl php5-xdebug php5-intl php5-gd php5-imagick php5-mcrypt vim mc git
RUN apt-get install -y pure-ftpd
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
RUN useradd  -ms /bin/bash b4zs -u 1000
RUN echo 'b4zs ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'b4zs:kamelot'|chpasswd


COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN  mkdir /root/bin
COPY root/bin/* /root/bin/




EXPOSE 21 22 80 8080 3306
CMD ["/usr/bin/supervisord"]
