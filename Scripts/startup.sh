#!/usr/bin/env bash

# mkdir /srv/SharedStorage
chown -R vagrant:vagrant /srv

# UnixODBC and cmake are needed to build the cache server
yum -q -y install unixODBC-devel
yum -q -y install cmake

echo "127.0.0.1	redis-master" >> /etc/hosts
echo "127.0.0.1	appserver" >> /etc/hosts
chkconfig redis on
service redis start

# bump up PHP file upload size
sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 128M/g' /etc/php.ini

# This is mostly for jnutt's benefit
cp /vagrant/Scripts/rxvt-unicode-256color /usr/share/terminfo/r/

echo "Install JBoss"
IWASHERE=$(pwd)
cd /root
wget -q http://artifact.cyberitas.com/StaticProvisioning/jboss-eap-6.1.0.zip
wget -q http://artifact.cyberitas.com/StaticProvisioning/mysql-connector-java-5.1.30.zip
wget -q http://artifact.cyberitas.com/StaticProvisioning/mysql-connector-java-5.1.30.zip-readme
wget -q http://artifact.cyberitas.com/StaticProvisioning/jboss7-cbc.sh
chmod 775 jboss7-cbc.sh
sed -i -e 's/^RUNAS\\=.*/RUNAS\\=\\"vagrant\\"/g' jboss7-cbc.sh
mv jboss7-cbc.sh /home/vagrant
chown vagrant:vagrant /home/vagrant/jboss7-cbc.sh
cd /srv/
echo "unzip ~/jboss-eap-6.1.0.zip into /srv/"
unzip ~/jboss-eap-6.1.0.zip >/dev/null 2>&1
chown -R vagrant:vagrant /srv/jboss-eap-6.1
ln -s jboss-eap-6.1 jboss
mkdir -p /srv/jboss/modules/system/layers/base/com/mysql/main
cd /srv/jboss/modules/system/layers/base/com/mysql/main
unzip ~/mysql-connector-java-5.1.30.zip
cd
pwd
echo "Install JBoss completed."
cd ${IWASHERE}

IWASHERE=$(pwd)
echo "Initializing MySQL databases."


echo "SMTP Set Relay Host"
echo "relayhost = 192.168.1.49" >> /etc/postfix/main.cf

cd ${IWASHERE}


# Drupal 8 Installation

# Drush Time
{
    drush version
} || {
    echo "Now installing Drush"

    # Download latest stable release using the code below or browse to github.com/drush-ops/drush/releases.
    php -r "readfile('http://files.drush.org/drush.phar');" > drush

    # Make `drush` executable as a command from anywhere. Destination can be anywhere on $PATH.
    chmod +x drush
    mv drush /usr/local/bin

    echo "Please wait while Drupal is downloading..."

    # Correctly position the directory into the Website folder and move into this directory
    cd ../
    echo "Currently in directory: "
    pwd
    /usr/local/bin/drush dl drupal
    sudo mv ./drupal-8.1.8 /var/www/html/Website
    sudo ln -fs /var/www/html/WebSite /vagrant/

}
echo "Drupal Setup Complete"