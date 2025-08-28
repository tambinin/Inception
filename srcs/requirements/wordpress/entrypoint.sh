#!/bin/bash
set -e

WP_PATH="/var/www/html"

echo "Waiting for MariaDB..."
until mysqladmin ping -h mariadb -u "${WORDPRESS_DB_USER}" -p"$(cat "${WORDPRESS_DB_PASSWORD_FILE}")" --silent; do
    echo "MariaDB not available, retry after 1s"
    sleep 1
done

DB_PASS=$(cat "$WORDPRESS_DB_PASSWORD_FILE" | tr -d '\n')
ADMIN_PASS=$(cat "$WORDPRESS_ADMIN_PASSWORD_FILE" | tr -d '\n')
USER_PASS=$(cat "$WORDPRESS_USER_PASSWORD_FILE" | tr -d '\n')

cd $WP_PATH

if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$DB_PASS" \
        --dbhost="mariadb" \
        --skip-check \
        --allow-root
fi

if ! wp core is-installed --allow-root; then
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Inception Project" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$ADMIN_PASS" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" --user_pass="$USER_PASS" --allow-root
fi

echo "Chown www-data"
chown -R www-data:www-data /var/www/html

echo "Starting php-fpm8.2"
exec php-fpm8.2 -F
