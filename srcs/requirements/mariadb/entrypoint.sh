#!/bin/bash
set -e

DB_PASS="$(cat ${MYSQL_PASSWORD_FILE})"
ROOT_PASS="$(cat ${MYSQL_ROOT_PASSWORD_FILE})"
DB_NAME="${MYSQL_DATABASE}"
DB_USER="${MYSQL_USER}"

mysqld_safe --skip-networking &
pid="$!"

until mysqladmin ping --silent; do
	    sleep 1
    done

    if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	        mysql -u root <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';
        CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
        CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
        GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
    fi

    mysqladmin -u root -p"${ROOT_PASS}" shutdown
    wait "$pid"

    exec mysqld_safe --user=mysql
