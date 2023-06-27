#!/bin/bash
# Help This target builds the go app
source .plan/scripts/init.sh

echo "- Running go-plan build step..."
export GO111MODULE=off
go env -w GO111MODULE=off
go build -o app
