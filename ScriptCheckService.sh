#!/bin/bash

SERVICE="httpd"
DATE=$(DATE '+%y-%M-%D %h:%M:%s')

if systemctl is-active --quiet "$SERVICE"; then
	STATUS="Online"
	MESSAGE="Serviço está online"
else
	STATUS="Offline"
	MESSAGE="Serviço está offline"
fi

nfs_share="/srv/nfs_share"

echo "%DATE - $SERVICE - Status: $STATUS = $MESSAGE" >> "$nfs_share/$STATUS.txt"