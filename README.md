
# json-syslog

[![CodeQL](https://github.com/tgragnato/json-syslog/actions/workflows/codeql.yml/badge.svg)](https://github.com/tgragnato/json-syslog/actions/workflows/codeql.yml) [![Docker](https://github.com/tgragnato/json-syslog/actions/workflows/docker.yml/badge.svg)](https://github.com/tgragnato/json-syslog/actions/workflows/docker.yml)

JsonSyslog is a syslog server that listens for log messages over both UDP and TCP on port 514. It creates an RFC5424 compliant server and waits for incoming messages.

Once a message is received, it parses it and verifies that the msg string is a JSON string.

![console output example](/.github/example.png)
