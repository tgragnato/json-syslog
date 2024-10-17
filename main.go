package main

import (
	"bytes"
	"encoding/json"
	"fmt"

	"gopkg.in/mcuadros/go-syslog.v2"
)

func main() {
	channel := make(syslog.LogPartsChannel)
	handler := syslog.NewChannelHandler(channel)

	server := syslog.NewServer()
	server.SetFormat(syslog.RFC5424)
	server.SetHandler(handler)
	server.ListenUDP("0.0.0.0:514")
	server.ListenTCP("0.0.0.0:514")

	server.Boot()

	go func(channel syslog.LogPartsChannel) {
		for logParts := range channel {
			fmt.Println(logParts)
			message, ok := logParts["message"].(string)
			if !ok {
				fmt.Println("Errore nel recupero del messaggio dal logParts")
				continue
			}

			var prettyJSON bytes.Buffer
			if err := json.Indent(&prettyJSON, []byte(message), "", "  "); err != nil {
				fmt.Printf("Errore nella formattazione del JSON: %s\n", err.Error())
			} else {
				fmt.Printf("Log JSON ricevuto: %s\n", prettyJSON.String())
			}
		}
	}(channel)

	server.Wait()
}
