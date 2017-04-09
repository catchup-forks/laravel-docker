#!/bin/bash

# Defaults to an app server
role=${CONTAINER_ROLE:-web}

echo "Container role: $role"

if [ "$role" = "queue" ]; then
    # Run the queue. In Laravel < 5.4 use  the --daemon flag to keep the process running
    php artisan queue:work --verbose --tries=3 --timeout=90
elif [ "$role" = "scheduler" ]; then
    # Run the scheduler
    while [ true ]
    do
      php artisan schedule:run --verbose --no-interaction
      sleep 60
    done
elif [ "$role" = "web" ]; then
    # Run the web server
    /usr/bin/caddy --conf /etc/Caddyfile
else
    echo "Could not match the container role...."
    exit 1
fi
