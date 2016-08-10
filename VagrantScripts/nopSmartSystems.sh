#!/bin/sh
set -e

rpm -Uvh http://artifact.cyberitas.com/StaticProvisioning/NopSmartSystems-5.2-20130821.x86_64.rpm

cd /etc/httpd
if [ ! -e conf.d/nopsmartsystems.conf ]; then
	cp conf/nopsmartsystems.conf conf.d/nopsmartsystems.conf
fi

/etc/init.d/httpd restart

