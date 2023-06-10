# syntax=docker/dockerfile:1
FROM golang:1.20 AS builder

## We create an /app directory in which
## we'll put all of our project code
RUN mkdir /app
WORKDIR /app
COPY *.go ./

## We want to build our application's binary executable
RUN GO111MODULE=off GOOS=linux go build -o /app

## the lightweight scratch image we'll
## run our application within
FROM alpine:latest AS production

COPY --from=builder /app .
EXPOSE 8080


CMD ["./app"]