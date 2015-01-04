#!/bin/bash

DOMAIN="${DOMAIN:localhost}"

mkdir -p /var/www/

CONFFILE=/var/www/reviewboard/conf/settings_local.py

if [[ ! -d /var/www/reviewboard ]]; then
    rb-site install --noinput \
        --domain-name="$DOMAIN" \
        --site-root=/ --static-url=static/ --media-url=media/ \
        --db-type=sqlite3 \
        --db-name=/data/reviewboard.db \
        --cache-type=memcached --cache-info=localhost:11211 \
        --web-server-type=lighttpd --web-server-port=8000 \
        --admin-user=admin --admin-password=admin --admin-email=admin@example.com \
        /var/www/reviewboard/
fi

service memcached start

exec  uwsgi --ini /uwsgi.ini
