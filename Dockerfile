FROM golang:alpine3.20 AS builder
ENV CGO_ENABLED=0
WORKDIR /workspace
COPY go.mod .
COPY go.sum .
COPY . .
RUN go mod download && go build .

FROM alpine:3.20
WORKDIR /tmp
COPY --from=builder /workspace/json-syslog /usr/bin/
EXPOSE 514/tcp
EXPOSE 514/udp
ENTRYPOINT ["/usr/bin/json-syslog"]
LABEL io.containers.autoupdate=registry
