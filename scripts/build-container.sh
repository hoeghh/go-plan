#!/bin/bash
# Help This target builds a container image with the go app
source .plan/scripts/init.sh

export IMAGE_TAG="${IMGTAG:-"latest"}"

if [ -f "bura.yaml" ]; then
    export IMAGE=$(cat bura.yaml | yq .vars.service.name)
    export REGISTRY_ORG=$(cat bura.yaml | yq .vars.registry.org)
fi
echo "- Running go-plan container build step..."
docker build -t $REGISTRY_ORG/$IMAGE:$IMAGE_TAG --file .plan/container/Dockerfile .
