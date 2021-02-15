service mysql start

#Permission
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

#Website folder
mkdir /var/www/localhost && touch /var/www/localhost index.php
echo "<?php phpinfo(); ?>" >> /var/www/localhost/index.php

#SSL
mkdir /etc/nginx/ssl 
openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 -nodes -out etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=saich/CN=localhost"

#Nginx
mv ./tmp/nginx-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

#MYSQL Database
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES on wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#PHPMYADMIN
mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.7-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
mv /tmp/phpmyadmin.php /var/www/localhost/phpmyadmin/config.inc.php

#Wordpress
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/localhost
mv /tmp/wp-config.php /var/www/localhost/wordpress

service php7.3-fpm start
service nginx start
bash
