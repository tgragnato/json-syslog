FROM cgr.dev/chainguard/go:latest AS builder
ENV CGO_ENABLED=0
WORKDIR /workspace
COPY go.mod .
COPY go.sum .
COPY . .
RUN go mod download && go build .

FROM ghcr.io/anchore/syft:latest AS sbomgen
COPY --from=builder /workspace/json-syslog /usr/bin/json-syslog
RUN ["/syft", "--output", "spdx-json=/json-syslog.spdx.json", "/usr/bin/json-syslog"]

FROM cgr.dev/chainguard/static:latest
WORKDIR /tmp
COPY --from=builder /workspace/json-syslog /usr/bin/
COPY --from=sbomgen /json-syslog.spdx.json /var/lib/db/sbom/json-syslog.spdx.json
EXPOSE 514/tcp
EXPOSE 514/udp
ENTRYPOINT ["/usr/bin/json-syslog"]
LABEL org.opencontainers.image.title="json-syslog"
LABEL org.opencontainers.image.description="Validator for JSON syslog messages"
LABEL org.opencontainers.image.url="https://tgragnato.it/json-syslog/"
LABEL org.opencontainers.image.source="https://tgragnato.it/json-syslog/"
LABEL license="AGPL-3.0"
LABEL io.containers.autoupdate=registry
