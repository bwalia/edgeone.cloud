#!/bin/sh
set -x

cat /Users/balinderwalia/Documents/Work/edgeone/edgeone_inventory.txt | while read ip
do
  echo "Deploying services to edgeone set of edge nodes"

    export TARGET=$ip
    export JWT_TOKEN=GGG
    curl -H "Token: $JWT_TOKEN" http://$TARGET:3333/redis_ping

 

    clear;curl -i -X POST -H "Token: $JWT_TOKEN" -H "Content-Type: multipart/form-data" -F "myFile=@/tmp/atest.json" -F "rename=atest.json" -F "host=www.tenthmatrix.co.uk " -F "svc=redis" http://$TARGET:3333/upload



    clear;curl -i -X POST -H "Token: $JWT_TOKEN" -H "Content-Type: multipart/form-data" -F "myFile=@/tmp/atest.json" -F "rename=atest.json" -F "host=tenthmatrix.co.uk " -F "svc=redis" http://$TARGET:3333/upload



    clear;curl -i -X POST -H "Token: $JWT_TOKEN" -H "Content-Type: multipart/form-data" -F "myFile=@/tmp/atest.json" -F "rename=atest.json" -F "host=hosting.tenthmatrix.co.uk " -F "svc=redis" http://$TARGET:3333/upload



    clear;curl -i -X POST -H "Token: $JWT_TOKEN" -H "Content-Type: multipart/form-data" -F "myFile=@/tmp/atest.json" -F "rename=atest.json" -F "host=domains.tenthmatrix.co.uk " -F "svc=redis" http://$TARGET:3333/upload


    curl -i -X POST -H "Token: $JWT_TOKEN" -H "Content-Type: multipart/form-data" -F "myFile=@/Users/balinderwalia/Desktop/cdn_edgenode_cfg/nginx/d967501bf5db41a5bea5760148a6544a.conf" -F "rename=d967501bf5db41a5bea5760148a6544a.conf" -F "svc=nginx" http://$TARGET:3333/upload

    curl -i -X POST -H "Token: $JWT_TOKEN" -H "Content-Type: multipart/form-data" -F "myFile=@/Users/balinderwalia/Desktop/cdn_edgenode_cfg/varnish/d967501bf5db41a5bea5760148a6544a.vcl" -F "rename=d967501bf5db41a5bea5760148a6544a.vcl" -F "svc=varnish" -F "host=www.tenthmatrix.co.uk" http://$TARGET:3333/upload

    curl -H "Token: $JWT_TOKEN" http://$TARGET:3333/nginx_restart

done