#! /bin/bash

set -e

echo "==> Setting up worker ${APP_ENV} environment"

# start gunicorn
echo "==> Starting: gunicorn"
circusd /etc/circus/worker.ini
