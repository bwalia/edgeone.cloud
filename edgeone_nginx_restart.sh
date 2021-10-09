#!/bin/sh
clear
set -x
#cd /Users/balinderwalia/Documents/Work/edgeone/
cat /Users/balinderwalia/Documents/Work/edgeone/edgeone_inventory.txt | while read ip
do
    export TARGET=$ip
    echo "Deploying services to edgeone set of edge nodes $TARGET"
#    export JWT_TOKEN=GGG
#    curl -H "Token: $JWT_TOKEN" http://$TARGET:3333/redis_ping
    curl -H "Token: $JWT_TOKEN" http://$TARGET:3333/nginx_restart
#    curl -H "Token: $JWT_TOKEN" http://$TARGET:3333/varnish_restart

    # ssh ec2-user@$TARGET 'sudo rm -Rf /usr/local/openresty/nginx/lua/main.lua'
    # ssh ec2-user@$TARGET 'sudo rm -Rf /usr/local/openresty/nginx/lua/init.lua'
    # rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/edgeone/terraform/nginx/lua/init.lua ec2-user@$TARGET:/tmp/init.lua
    # rsync --update -raz --progress --delete /Users/balinderwalia/Documents/Work/edgeone/terraform/nginx/lua/main.lua ec2-user@$TARGET:/tmp/main.lua
    # ssh ec2-user@$TARGET 'sudo mv /tmp/init.lua /usr/local/openresty/nginx/lua/init.lua'
    # ssh ec2-user@$TARGET 'sudo mv /tmp/main.lua /usr/local/openresty/nginx/lua/main.lua'
    # ssh ec2-user@$TARGET 'sudo systemctl stop openresty.service'
    # ssh ec2-user@$TARGET 'sudo systemctl start openresty.service'
    ssh ec2-user@$TARGET 'sudo systemctl status openresty.service'
    ssh ec2-user@$TARGET 'sudo lsof -i:80'

    ssh ec2-user@$TARGET 'curl -IL localhost'
    #ssh ec2-user@$TARGET 'curl -H "host: www.tenthmatrix.co.uk" http://localhost/.well-known/acme-challenge/359CWni__1CYP_53Tp8mI3ypXKOehs0TjzTHdeS_Fus'
done

# cat /Users/balinderwalia/Documents/Work/edgeone/edgeone_inventory.txt | while read ip
# do
#     export TARGET=$ip
#     echo "Varnish stat $TARGET"
#     ssh ec2-user@$TARGET 'sudo /usr/local/bin/varnishstat'
#     # ssh ec2-user@$TARGET 'sudo rm -Rf /opt/varnish/conf/varnish-tenants.d/*.vcl'
#     # ssh ec2-user@$TARGET 'sudo rm -Rf /opt/varnish/conf/varnish-tenants.d/*.host'

#     #ssh ec2-user@$TARGET 'sudo cat /usr/local/openresty/nginx/conf/nginx-core.d/default.conf'
#     #ssh ec2-user@$TARGET 'sudo ls -alth /opt/varnish/conf/varnish-tenants.d/'
#     #ssh ec2-user@$TARGET 'sudo /usr/local/bin/varnishadm vcl.list'
#     #ssh ec2-user@$TARGET 'sudo openresty -T | grep "unix"'
#     #ssh ec2-user@$TARGET 'sudo ls -alth /opt/varnish/conf/varnish-tenants.d/'
#     #ssh ec2-user@$TARGET 'sudo cat /opt/varnish/conf/varnish-tenants.d/3f9737b5301544a89799ac144f3c162f.vcl'
# done
