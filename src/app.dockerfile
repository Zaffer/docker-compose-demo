# Use striped down python image
FROM python:3.8-alpine
# FROM python:3.8
# FROM ubuntu:20.04

# update package manager cache and upgrade packages
RUN apk -U upgrade

# add bash to the to be able run bash scripts
RUN apk add --no-cache --upgrade bash

# copy file forces docker to check for changes
COPY requirements.txt /
COPY requirements-dev.txt /

# get argument from docker-compose if development environment
ARG INSTALL_DEV=false

# create virtual package compiler for pip installs
# pip install requirements
RUN bash -c " \
        if [ $INSTALL_DEV == 'true' ] ; then \
            apk add --no-cache --upgrade --virtual .build-deps build-base postgresql-dev; \
            pip install --no-cache-dir -r /requirements-dev.txt; \
            apk del .build-deps build-base postgresql-dev; \
        else \
            apk add --no-cache --upgrade --virtual .build-deps gcc libc-dev make g++; \
            pip install --no-cache-dir -r /requirements.txt; \
            apk del .build-deps gcc libc-dev make g++; \
        fi"


# copy start.sh into the image for production running
COPY ./start.sh /start.sh

# copy start-reload.sh into the image for development running
COPY ./start-dev.sh /start-dev.sh

# copy app folder to app folder
COPY ./app /app
# WORKDIR /app/

# Run the start script, it will check for an /app/prestart.sh script
CMD ["/start.sh"]