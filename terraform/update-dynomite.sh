#!/bin/bash

set -x

echo "Updating Dynomite with redis cluster to be sync'd..."

TARGET=$(</Users/balinderwalia/Documents/Work/edgeone/terraform/public_ips.txt)

if [ -z ${REMOTE_POP_REDIS_IP} ];
then
    REMOTE_POP_REDIS_IP=$(</Users/balinderwalia/Documents/Work/edgeone/terraform_singapore/public_ips.txt)
fi
if [ -z ${REMOTE_POP_REDIS_PORT} ];
then
    REMOTE_POP_REDIS_PORT="8101"
fi

if [ -z ${TARGET} ];
then
echo "Target is empty"
else
sed "s^#REMOTE_POP_REDIS_IP#^$REMOTE_POP_REDIS_IP^g;s^#REMOTE_POP_REDIS_PORT#^$REMOTE_POP_REDIS_PORT^g" templates/dynomite-template.yml > templates/dynomite.yml

rsync --update -raz --progress --delete templates/dynomite.yml ec2-user@$TARGET:/tmp/dynomite.yml

ssh ec2-user@$TARGET 'sudo mv /tmp/dynomite.yml /usr/local/etc/dynomite.yml'
ssh ec2-user@$TARGET '/home/ec2-user/dynomite/src/dynomite -t'
ssh ec2-user@$TARGET '/home/ec2-user/dynomite/src/dynomite -d'

fi