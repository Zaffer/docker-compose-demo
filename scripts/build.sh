#! /usr/bin/env sh

# This script is for building the production image

# Exit in case of error
set -e

# run the script like this: "bash scripts/build.sh"
docker-compose -f docker-compose.yml build
# docker-compose -f docker-compose.yml build --no-cache