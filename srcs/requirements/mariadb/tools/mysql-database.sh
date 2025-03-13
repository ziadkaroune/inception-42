#!/bin/bash

# Start MySQL service
service mysql start


# Check if the database already exists
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Creating database: ${MYSQL_DATABASE}"
    
    # Create the database
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

    # Create the user and grant privileges
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

    # Flush privileges
    mysql -e "FLUSH PRIVILEGES;"
fi

# Stop the MySQL service to finalize setup
service mysql stop

# Start the MySQL server in safe mode
exec mysqld_safe
