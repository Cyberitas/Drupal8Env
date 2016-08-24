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

    # Import latest headless drupal code w/modules (maintained by Cyberitas)
    git clone https://github.com/Cyberitas/Drupal8Ang.git
    #Installing Angular pre-req
    sudo npm install -g bower

    #Initializing angular drupal start
    git clone https://github.com/Cyberitas/AngularApp.git
    cd AngularApp
    sudo npm install
    # Import angular theme and modules (Cyberitas only)

    # Move things around as needed

    #Database import

    sudo ln -fs /vagrant/Drupal8Ang/ /var/www/html/
    sudo cp -r /vagrant/cyberitas/ /vagrant/Drupal8Ang/profiles/

    # Have to make some apache changes, maybe we should update our CentOS?
    sed -i '338d' /etc/httpd/conf/httpd.conf
    sed -i '338i\AllowOverride All' /etc/httpd/conf/httpd.conf
    sudo service httpd restart
    cd /home/vagrant/Drupal8Ang

    sudo /usr/local/bin/drush  si standard -y --account-name=admin --account-pass=admin --db-url=mysql://root@localhost/COneDev --site-name=Cable_One
    # Module Setup
    sudo /usr/local/bin/drush  en -y hal rest serialization basic_auth
}
echo "Drupal Setup Complete"