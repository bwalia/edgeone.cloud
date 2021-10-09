#!/bin/bash

set -x

amazon-linux-extras install epel -y
yum install gcc jemalloc-devel openssl-devel tcl tcl-devel -y

cd /tmp/src && tar -xvzf /tmp/src/redis-stable.tar.gz

cd /tmp/src/redis-stable

#make BUILD_TLS=yes

gmake && gmake install

# cat << EOF | sudo tee -a /etc/hosts
# 127.0.0.1   redis.edgeone.cloud
# EOF

#yum install git -y

# cd /tmp && tar -xvzf /tmp/src/dynomite-dev.tar.gz -C /tmp/src

# mv /tmp/src/dynomite-dev /home/ec2-user/dynomite/

# chown ec2-user:root /home/ec2-user/dynomite
# chmod +x /home/ec2-user/dynomite
# chmod 777 /home/ec2-user/dynomite

# cd /home/ec2-user/dynomite

# sudo git clone https://github.com/Netflix/dynomite.git
# # cd dynomite
# sudo yum install -y autoconf automake
# sudo yum install -y libtool
# sudo yum install -y openssl-devel
# sudo autoreconf -fvi
# sudo ./configure --enable-debug=log
# #sudo make
# ./build.sh

# mkdir -p /usr/local/etc/
# mv /tmp/dynomite.yml /usr/local/etc/dynomite.yml

#cd /home/ec2-user/dynomite
# /home/ec2-user/dynomite/src/dynomite -t
# /home/ec2-user/dynomite/src/dynomite -d