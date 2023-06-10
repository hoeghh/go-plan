echo "Running go-plan build step..."
export GO111MODULE=off
go env -w GO111MODULE=off
go build -o app
