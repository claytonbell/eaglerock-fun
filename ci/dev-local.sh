#!/bin/bash
# local dev docker so you can run interactive dotnet commands
# ./ci/dev/-local bash
#
# run the app locally
# ./ci/dev-local
set -e

IMAGE=eaglerock-api-dev

cd "$(dirname "$0")/.."

docker build --rm --tag "${IMAGE}" .

docker run -ti --rm \
  --user "$(id -u):$(id -g)" \
  --volume "$(pwd):/app" \
  -p 5000:5000 \
  "${IMAGE}" \
  "${@}"
