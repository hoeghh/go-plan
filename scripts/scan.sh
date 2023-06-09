if ! command -v sysdig-cli-scanner &> /dev/null; then
    echo "sysdig-cli-scanner could not be found"
    exit 1
fi

if [ -z "$SECURE_API_TOKEN" ];then
      export SECURE_API_TOKEN=$1
fi

export IMAGE_TAG="${IMGTAG:-"latest"}"

if [ -f "bura.yaml" ]; then
    export IMAGE=$(cat bura.yaml | yq .vars.service.name)
    export REGITRY_URL=$(cat bura.yaml | yq .vars.service.registry.url)
    export REGITRY_PORT=$(cat bura.yaml | yq .vars.service.registry.port)
    export REGISTRY_ORG=$(cat bura.yaml | yq .vars.service.registry.org)
fi

mkdir -p sysdig.scan

sysdig-cli-scanner \
    --apiurl https://eu1.app.sysdig.com/secure/ \
    --dbpath=sysdig.scan/ \
    --output-json=sysdig.scan/results.json \
    --logfile=sysdig.scan/scan.log \
    $REGISTRY_ORG/$IMAGE:$IMAGE_TAG > sysdig.scan/scanner.output

if [ -f "sysdig.scan/results.json" ]; then
    CRITICAL_COUNT=$(cat sysdig.scan/results.json | jq -r '.vulnerabilities.bySeverity[] | select(.severity.label=="Critical") | .total')
    HIGH_COUNT=$(cat sysdig.scan/results.json     | jq -r '.vulnerabilities.bySeverity[] | select(.severity.label=="High") | .total')
    MEDIUM_COUNT=$(cat sysdig.scan/results.json   | jq -r '.vulnerabilities.bySeverity[] | select(.severity.label=="Medium") | .total')
    RESULT_URL=$(cat sysdig.scan/results.json     | jq -r '.info.resultURL')
    
    echo "- Scanned $(date) by Sysdig"
    echo "- Severity : "
    echo "   - Critical : $CRITICAL_COUNT"
    echo "   - High     : $HIGH_COUNT"
    echo "   - Medium   : $MEDIUM_COUNT"
    echo "- View results at $RESULT_URL"
else
    exit 1
fi
