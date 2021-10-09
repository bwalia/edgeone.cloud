#!/bin/bash

set -x

# Set variables
SCRIPTS_DEST_DIR="/opt/varnish/scripts/"
CONFIG_DIR="/opt/varnish/conf/"
TENANTS_CONFIG_DIR="{CONFIG_DIR}varnish-tenants.d/"

VARNISH_UNIX_SOCKET_PATH="/var/run/varnish/"
VARNISH_UNIX_SOCKET="/var/run/varnish/varnish.sock"

########## Install varnish varnish-6.6.1 ##########
echo "Installing Varnish-6.6.1..."

#curl -s https://packagecloud.io/install/repositories/varnishcache/varnish60lts/script.rpm.sh | sudo bash

#yum install varnish -y

#mkdir -p /usr/local/varnish
#chmod +x /usr/local/varnish

########## Add nginx varnish dependencies pcre-devel, python3-sphinx and python3-docutils and automake conf files etc ##########
sudo yum install \
    make \
    autoconf \
    automake \
    jemalloc-devel \
    libedit-devel \
    libtool \
    ncurses-devel \
    pcre-devel \
    pkgconfig \
    python3-docutils \
    python3-sphinx -y

cd /tmp/src && tar -xvzf /tmp/src/varnish-6.6.1.tgz

########## Get varnish-6.6.1 src / tar which was copied by terraform ##########
#mv /tmp/src/varnish-6.6.1 /usr/local/varnish

cd /tmp/src/varnish-6.6.1
#/usr/local/varnish
        
sh autogen.sh
sh configure
# --prefix=/usr/local/varnish

########## Compile varnish openresty from source ##########
make
#make check
make install

#  varnish pid file location preset
pidFileDir="/var/varnish/"

mkdir -p ${pidFileDir}
chown root:root ${pidFileDir}
pidFile="${pidFileDir}varnish.pid"
touch ${pidFile}

mkdir -p ${VARNISH_UNIX_SOCKET_PATH}
chmod +x ${VARNISH_UNIX_SOCKET_PATH}
chown ec2-user:root ${VARNISH_UNIX_SOCKET_PATH}
chmod 755 -R ${VARNISH_UNIX_SOCKET_PATH}

########## Configure varnishd unit systemd file ##########
FILE=/tmp/varnish.service
if [ -f "$FILE" ]; then
mv /tmp/varnish.service /etc/systemd/system/varnish.service
FILE=/etc/systemd/system/varnish.service
chown root:root /etc/systemd/system/varnish.service
fi

if [ -f "$FILE" ]; then
systemctl daemon-reload
systemctl enable varnish.service
systemctl start varnish.service
systemctl status varnish.service
fi

########## Add nginx/varnish in the path ##########
export PATH=/usr/local/varnish/bin/:$PATH

echo 'export PATH=/usr/local/bin/:$PATH' >> ~/.bashrc
echo 'export PATH=/usr/local/sbin/:$PATH' >> ~/.bashrc
#Also add path for sudo commands in root bashrc
echo 'export PATH=/usr/local/bin/:$PATH' >> /root/.bashrc
echo 'export PATH=/usr/local/sbin/:$PATH' >> /root/.bashrc

########## Check and display varnish version in console ##########
varnishd -V

# Create dedicated location for varnish files
mkdir -p ${CONFIG_DIR}
mv -f /tmp/varnish/default.vcl ${CONFIG_DIR}default.vcl

########## Restart varnish service so default config is active ##########

systemctl restart varnish.service

# set tenants varnish config dedicated location so nginx tenant specific configs can be added via API
mkdir -p ${TENANTS_CONFIG_DIR}
chmod +x ${TENANTS_CONFIG_DIR}
chown ec2-user:root ${TENANTS_CONFIG_DIR}
chmod 755 -R ${TENANTS_CONFIG_DIR}
