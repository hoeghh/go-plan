export IMAGE_TAG="${IMGTAG:-"latest"}"

if [ -f "bura.yaml" ]; then
    export IMAGE=$(cat bura.yaml | yq .vars.service.name)
    export REGISTRY_ORG=$(cat bura.yaml | yq .vars.service.registry.org)
fi

docker build -t $REGISTRY_ORG/$IMAGE:$IMAGE_TAG --file .plan/container/Dockerfile .
