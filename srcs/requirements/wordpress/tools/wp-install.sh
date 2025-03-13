#!/bin/bash


cd /var/www/html/

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Downloading WordPress source code..."
    
    curl -sO https://wordpress.org/latest.tar.gz
    curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    tar -xzf latest.tar.gz
    rm latest.tar.gz

    mv wordpress/* .
    rm -rf wordpress

    cp wp-config-sample.php wp-config.php

    # Update PHP-FPM to listen to 9000 : port
    sed -i 's/\/run\/php\/php7.3-fpm.sock/9000/' /etc/php/7.3/fpm/pool.d/www.conf
    #connect to database with mariadb // config.php file
    sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php
    sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
    sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config.php
    sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config.php


    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    #installation automatqiue de wordpress (skip 5 min installation page)
    if ! wp core is-installed --allow-root; then
        wp core install \
            --url="$WORDPRESS_URL" \
            --title="$WORDPRESS_TITLE" \
            --admin_user="$WORDPRESS_ADMIN_USER" \
            --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
            --admin_email="$WORDPRESS_ADMIN_EMAIL" \
            --allow-root 
    fi
    #create new user
    wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASSWORD --role='author' --allow-root
    
fi

exec "$@"