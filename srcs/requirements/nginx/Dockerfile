FROM debian:bookworm

RUN apt-get update \
 && apt-get install -y nginx openssl \
 && apt-get clean

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/sites-available/default

RUN mkdir -p /etc/nginx/sites-enabled \
    && ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

COPY conf/snippets/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf


RUN openssl req -x509 -nodes -days 365 \
	-subj "/C=MG/ST=Antananarivo/L=Antananarivo/O=42/CN=tambinin.42.fr" \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
