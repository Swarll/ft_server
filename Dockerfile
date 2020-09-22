FROM debian:buster

LABEL maintainer=grigaux

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php7.3-fpm
RUN apt-get install -y php-mysql
#RUN apt-get install -y openssl


COPY /srcs/nginx.conf /etc/nginx/sites-enabled/
COPY /srcs/phpMyAdmin /var/www/phpmyadmin
COPY /srcs/wordpress /var/www/wordpress

# linking nginx configuration file as default
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# Unlinking nginx default configuration file
RUN unlink /etc/nginx/sites-enabled/default

#RUN service mysql start | mariadb -u root

CMD service mysql start && service php7.3-fpm start && nginx -g "daemon off;"
#CMD ["echo", "hello from image"]
