#!/bin/bash
# Help This target builds a container image with the go app
source .plan/scripts/init.sh

export IMAGE_TAG="${IMGTAG:-"latest"}"
export IMAGE=${service_name}
export REGISTRY_ORG=${registry_org}

echo "- Running go-plan container build step..."
docker build -t $REGISTRY_ORG/$IMAGE:$IMAGE_TAG --file .plan/container/Dockerfile .
