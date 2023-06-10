# syntax=docker/dockerfile:1
FROM golang:1.20 AS builder

RUN mkdir /app
WORKDIR /app
COPY *.go .

RUN GO111MODULE=off CGO_ENABLED=0 GOOS=linux go build -o app

RUN chmod u+x /app/app
RUN ls -l /app/

FROM scratch
COPY --from=builder /app .
EXPOSE 8080

CMD ["./app"]