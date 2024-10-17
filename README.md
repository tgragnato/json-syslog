
# json-syslog

JsonSyslog is a syslog server that listens for log messages over both UDP and TCP on port 514. It creates an RFC5424 compliant server and wait for incoming messages.

Once a message is received it parses it and verify that the msg string is a JSON string.
