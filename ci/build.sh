#!/bin/bash
set -e

cd "$(dirname "$0")/.."

source ./ci/config

docker build --rm -t "${IMAGE}" .

# assumption
# - CI agent is already has a role/credentials to push to the ECR registery
# - amazon-ecr-credential-helper is installed which automatically configures
#   docker with credentials.  Perhaps there's a better gitlab way of doing this?
#
docker push "${IMAGE}"
