GOOS=linux \
GOARCH=amd64 \
CGO_ENABLED=0 \
go build -o dist/tiger -ldflags="-s -w" main.go