#!/bin/bash
set -e

cd "$(dirname "$0")/.."

source ./ci/config

env="$1"  # which account we're deploying i.e. which config to deploy

if [[ "${env}" != "production" ]] || [[ "${env}" != "staging" ]]; then
  echo "Error: $0 production|staging"
  exit 1
fi

source ./deploy/config-"${env}"

# re-tag image and publish to account
# assumptions
# - CI agent is running in the target account with permission to pull
#   from dev and push to target ECR
docker pull "${IMAGE}"
docker tag -t "$DEPLOY_IMAGE}" "${IMAGE}"
docker push "${DEPLOY_IMAGE}"

# login to EKS cluster
# assumption
# - CI agent is running in the target account with permission to deploy
# - or OICD login has already occured to assume the right role
aws eks update-kubeconfig --name "eks-cluster-${env}"

export DEPLOY_IMAGE
export HPA_MAX_REPLICAS
export HPA_CPU_AVERAGE
envsubst < deploy/kube-eaglerock-api.yaml | kubectl apply -f -

