FROM debian:buster

RUN apt -y update \
    && apt install wget php php-mysql -y 

# Copy and fix the script
COPY ./tools/adminer.sh /adminer.sh
RUN chmod +x /adminer.sh

# Expose the correct port
EXPOSE 80

# Start Adminer
CMD ["/adminer.sh"]
