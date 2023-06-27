#!/bin/bash
# Help This target security scan the go app
source .plan/scripts/init.sh

if ! command -v sysdig-cli-scanner &> /dev/null; then
    echo "- sysdig-cli-scanner could not be found"
    echo "- Install on mac via :"
    echo "  - curl -LO \"https://download.sysdig.com/scanning/bin/sysdig-cli-scanner/$(curl -L -s https://download.sysdig.com/scanning/sysdig-cli-scanner/latest_version.txt)/$(uname -s | tr '[:upper:]' '[:lower:]')/amd64/sysdig-cli-scanner\""
    echo "  - sudo mv sysdig-cli-scanner /usr/local/bin"
    echo "  - chmod u+x /usr/local/bin/sysdig-cli-scanner"
    exit 1
fi

if [ -z "$SECURE_API_TOKEN" ];then
      echo "- Environment variable SECURE_API_TOKEN is empty... exiting."
      exit 1
fi

export IMAGE_TAG="${IMGTAG:-"latest"}"

if [ -f "bura.yaml" ]; then
    export IMAGE=$(cat bura.yaml | yq .vars.service.name)
    export REGITRY_URL=$(cat bura.yaml | yq .vars.registry.url)
    export REGITRY_PORT=$(cat bura.yaml | yq .vars.registry.port)
    export REGISTRY_ORG=$(cat bura.yaml | yq .vars.registry.org)
fi

mkdir -p .scan
echo "- Running go-plan container security scan step..."
sysdig-cli-scanner \
    --apiurl https://eu1.app.sysdig.com/secure/ \
    --dbpath=.scan/ \
    --output-json=.scan/results.json \
    --logfile=.scan/scan.log \
    $REGISTRY_ORG/$IMAGE:$IMAGE_TAG > .scan/scanner.output

if [ -f ".scan/results.json" ]; then
    CRITICAL_COUNT=$(cat .scan/results.json | jq -r '.vulnerabilities.bySeverity[] | select(.severity.label=="Critical") | .total')
    HIGH_COUNT=$(cat .scan/results.json     | jq -r '.vulnerabilities.bySeverity[] | select(.severity.label=="High") | .total')
    MEDIUM_COUNT=$(cat .scan/results.json   | jq -r '.vulnerabilities.bySeverity[] | select(.severity.label=="Medium") | .total')
    RESULT_URL=$(cat .scan/results.json     | jq -r '.info.resultURL')
    
    echo "- Scanned $(date) by Sysdig"
    echo "- Severity : "
    echo "   - Critical : $CRITICAL_COUNT"
    echo "   - High     : $HIGH_COUNT"
    echo "   - Medium   : $MEDIUM_COUNT"
    echo "- View results at $RESULT_URL"
else
    exit 1
fi
