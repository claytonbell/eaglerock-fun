#!/bin/bash
set -e

cd "$(dirname "$0")/.."

source ./ci/config

# assumption
# - CI agent is authorized to docker pul from ECR
docker run --rm -t "${IMAGE}" dotnet test src/HelloWorldApi.Tests
