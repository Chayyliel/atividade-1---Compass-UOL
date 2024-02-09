#!/bin/bash

SERVICE=$"httpd"
DATE=$(date +%d-%m-%Y)
TIME=$(date +%H:%M:%S)

if systemctl is-active --quiet "$SERVICE"; then
	STATUS="Online"
	MESSAGE="Serviço está online"
else
	STATUS="Offline"
	MESSAGE="Serviço está offline"
fi

echo "$DATE - $TIME - $SERVICE - Status: $STATUS = $MESSAGE" >> <caminho_do_diretorio>/$STATUS.txt
