#!/usr/bin/env bash

if [ ! -f .env ]; then
    echo ".env File not found!"
    echo "copy .example.env to .env"
    echo "be sure to have editted the .env file and check that EXTERNAL_URL and DOMAIN name is set for your environment"
    echo "SECRET_KEY is best changed too."
    exit 1
fi

CUSTOM_CONF_FILE="custom/conf/app.ini"
echo "updating custom configuration ..."
echo ""
./custom_conf.sh > $CUSTOM_CONF_FILE
echo "see the contents of ${CUSTOM_CONF_FILE}"