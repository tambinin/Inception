FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y php php-fpm php-mysql php-cli php-curl php-gd php-xml \
       php-mbstring php-json php-zip php-dom php-tokenizer curl tar unzip wget \
	mariadb-client \
    && apt-get clean

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xvzf latest.tar.gz \
	&& mv wordpress/* /var/www/html \
	&& rm -rf latest.tar.gz

RUN chown -R root:root /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY conf/php.ini /etc/php/8.2/fpm/php.ini
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
