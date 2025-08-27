FROM debian:bookworm

RUN apt-get update \
 && apt-get install -y mariadb-server \
 && apt-get clean

RUN chown -R mysql:mysql /var/lib/mysql

COPY conf/99-custom.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf
COPY conf/my.cnf /etc/mysql/my.cnf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
