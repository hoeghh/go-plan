echo "Running go-plan build step..."
go env -w GO111MODULE=off
go build -o app
