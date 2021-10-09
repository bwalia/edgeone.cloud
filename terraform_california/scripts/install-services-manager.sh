#!/bin/bash

set -x

########## Install services manager ##########
echo "Installing Go App - The services config manager..."

cd /tmp && tar -xvzf /tmp/src/services.tar.gz -C /tmp/src

mv /tmp/src/services /home/ec2-user/services

chown ec2-user:root /home/ec2-user/services
chmod +x /home/ec2-user/services
chmod 777 /home/ec2-user/services

FILE="/tmp/services-manager.service"

if [ -f "$FILE" ]; then
mv /tmp/services-manager.service /etc/systemd/system/services-manager.service
FILE=/etc/systemd/system/services-manager.service
chown root:root /etc/systemd/services-manager.service
fi

if [ -f "$FILE" ]; then
systemctl daemon-reload
systemctl enable services-manager.service
systemctl start services-manager.service
systemctl status services-manager.service
fi
#nohup /home/ec2-user/services &

curl http://localhost:3333/
