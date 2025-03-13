#!/bin/bash

# Download Adminer
wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php 

# Set correct permissions
chown -R www-data:www-data /var/www/html/adminer.php 
chmod 755 /var/www/html/adminer.php

# Remove default index.html if it exists
rm -f /var/www/html/index.html

# Start PHP built-in server on port 80
php -S 0.0.0.0:80 -t /var/www/html /var/www/html/adminer.php

