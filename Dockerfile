FROM debian:buster

LABEL maintainer=grigaux

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y nginx
RUN apt-get install -y php7.3-fpm
RUN apt-get install -y php7.3-mysql
RUN apt-get install -y mariadb-server
#RUN apt-get install -y openssl


COPY /srcs/nginxconf /etc/nginx/sites-available/
COPY /srcs/phpMyAdmin /var/www/phpmyadmin
COPY /srcs/wordpress /var/www/wordpress

# linking nginx configuration file as default
CMD ln -s /etc/nginx/sites-available/nginxconf /etc/nginx/sites-enabled/
CMD unlink /etc/nginx/sites-enabled/default/

CMD service mysql start && service php7.3-fpm start && nginx -g "daemon off;"
