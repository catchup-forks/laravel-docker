#!/usr/bin/env bash

export APP_DEBUG=false \
&& export APP_ENV=production

php --version
ec=$?; if [[ $ec != 0 ]]; then exit $ec; fi

# Build application
root=$(pwd)
cd src/

printf "Yarn Version: $(yarn --version)"
yarn install
ec=$?; if [[ $ec != 0 ]]; then exit $ec; fi

composer install \
    --no-ansi \
    --no-dev \
    --no-interaction \
    --no-progress \
    --no-scripts \
    --optimize-autoloader \
    --ignore-platform-reqs

ec=$?; if [[ $ec != 0 ]]; then exit $ec; fi

php artisan optimize
ec=$?; if [[ $ec != 0 ]]; then exit $ec; fi

npm run production
ec=$?; if [[ $ec != 0 ]]; then exit $ec; fi

cd $root
docker-compose build
ec=$?; if [[ $ec != 0 ]]; then exit $ec; fi
