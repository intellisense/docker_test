#! /bin/bash

set -e

echo "==> Setting up web ${APP_ENV} environment"

# test nginx conf
nginx -t

# start nginx
echo "==> Starting: nginx"
circusd /etc/circus/web.ini
