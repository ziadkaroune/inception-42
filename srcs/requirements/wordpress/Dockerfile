FROM debian:buster


RUN apt update && apt upgrade -y \
    && apt install -y php7.3 php7.3-curl php7.3-mysql php7.3-fpm curl \
    && apt clean

RUN mkdir -p /run/php /var/www/html

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

COPY ./tools/wp-install.sh /wp-install.sh
RUN chmod +x /wp-install.sh

EXPOSE 9000

ENTRYPOINT ["/wp-install.sh", "php-fpm7.3", "-F"]