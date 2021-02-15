FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx && apt-get install -y procps
RUN apt-get install -y mariadb-server
RUN apt-get install -y openssl
RUN apt-get install -y php-fpm php-mysql php-mbstring php-zip php-gd php7.3 php7.3-common php7.3-mbstring php7.3-xmlrpc php7.3-soap php7.3-gd php7.3-xml php7.3-intl php7.3-mysql php7.3-cli php7.3-ldap php7.3-zip php7.3-curl
RUN apt-get install -y wget
RUN apt-get install -y nano

COPY ./srcs/start.sh ./
COPY ./srcs/nginx-conf ./tmp/nginx-conf
COPY ./srcs/phpmyadmin.php ./tmp/phpmyadmin.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php

CMD bash start.sh
