# build and start container

docker-compose up

# ports, database:

the compose file maps the internal ports of the containers as follows:

50080: web
50022: ssh
53306: mysql


#directories: 

../src: mapped to /var/www
../src/html: mapped to /var/www/html <- this is the document root for the webserver
../mysql: mapped to /var/lib/mysql <- data directory for mysql