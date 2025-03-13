FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx 

RUN mkdir -p /etc/nginx/ssl

RUN apt-get install openssl -y && apt-get clean
RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=PL/ST=Mazovia/L=Warsaw/O=42/OU=42/CN=zkaroune.42.fr/UID=zkaroune"

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html 

RUN mkdir -p /etc/nginx/conf.d

COPY ./nginx.conf /etc/nginx/conf.d/default.conf 

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ] 