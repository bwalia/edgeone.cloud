#!/usr/bin/env bash
# -- Author: Balinder Walia --
# -- Pushes the edge src code to target edge nodes

set -x

ssh root@35.176.49.205 'mkdir -p /usr/local/openresty/nginx/conf/autossl/'
ssh root@35.176.49.205 'mkdir -p /usr/local/openresty/nginx/conf/nginx-edge.d/'
ssh root@35.176.49.205 'mkdir -p /usr/local/openresty/nginx/conf/nginx-ssl.d/'
ssh root@35.176.49.205 'mkdir -p /usr/local/openresty/nginx/lua/'
ssh root@35.176.49.205 'mkdir -p /usr/local/openresty/nginx/secrules/'
ssh root@35.176.49.205 'mkdir -p /etc/ssl/'
# ssh root@35.176.49.205 'mkdir -p /usr/local/bin'

rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/resty-auto-ssl/ root@35.176.49.205:/usr/local/bin/resty-auto-ssl/

rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/ssl/ root@35.176.49.205:/etc/ssl/
rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/autossl/ root@35.176.49.205:/usr/local/openresty/nginx/conf/autossl/

rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/secrules/ root@35.176.49.205:/usr/local/openresty/nginx/secrules/

rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/conf/nginx-edge.d/ root@35.176.49.205:/usr/local/openresty/nginx/conf/nginx-edge.d/
rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/conf/nginx-ssl.d/ root@35.176.49.205:/usr/local/openresty/nginx/conf/nginx-ssl.d/

rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/conf/nginx-core.d/default.conf root@35.176.49.205:/usr/local/openresty/nginx/conf/nginx-core.d/default.conf
rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/conf/nginx-core.d/gtg.conf root@35.176.49.205:/usr/local/openresty/nginx/conf/nginx-core.d/gtg.conf
rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/conf/nginx-core.d/info.conf root@35.176.49.205:/usr/local/openresty/nginx/conf/nginx-core.d/info.conf

rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/lua/ root@35.176.49.205:/usr/local/openresty/nginx/lua/

rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/Edgeone/nginx/conf/nginx.conf root@35.176.49.205:/usr/local/openresty/nginx/conf/nginx.conf


ssh root@35.176.49.205 'systemctl restart openresty.service'
ssh root@35.176.49.205 'systemctl status openresty.service'
