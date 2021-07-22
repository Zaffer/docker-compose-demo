#! /usr/bin/env sh

# Exit in case of error
set -e

# If there's a prestart.sh script in the /app directory, run it before starting (to run migrations etc.)
PRE_START_PATH=/app/prestart.sh
echo "Checking for script in $PRE_START_PATH"

if [ -f $PRE_START_PATH ] ; then
    echo "Running script $PRE_START_PATH"
    . "$PRE_START_PATH"
else 
    echo "There is no script $PRE_START_PATH"
fi

# # Start Gunicorn + Uvicorn
# exec gunicorn -k uvicorn.workers.UvicornWorker -c "$GUNICORN_CONF" "$APP_MODULE"

# TODO ? Tiangolo
# Start single Uvicorn worker
uvicorn app.main:app --host 0.0.0.0 --port 8080 --log-level info --workers 1