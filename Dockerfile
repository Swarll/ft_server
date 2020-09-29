FROM debian:buster

LABEL maintainer=grigaux

RUN apt-get update
RUN apt-get install -y sudo
RUN apt-get install -y nginx
RUN apt-get install -y php7.3-fpm
RUN apt-get install -y php7.3-mysql
RUN apt-get install -y mariadb-server
RUN apt-get install -y openssl


COPY /srcs/nginxconf /etc/nginx/sites-available/
COPY /srcs/phpMyAdmin /var/www/phpmyadmin
COPY /srcs/wordpress /var/www/wordpress 

RUN ln -sf /etc/nginx/sites-available/nginxconf /etc/nginx/sites-enabled/
RUN unlink /etc/nginx/sites-enabled/default

COPY srcs/db_init.sql .
RUN service mysql start && cat db_init.sql | mariadb -u root

CMD service mysql start && service php7.3-fpm start && nginx -g "daemon off;"
