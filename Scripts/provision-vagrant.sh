#!/usr/bin/env bash

# mkdir /srv/SharedStorage
chown -R vagrant:vagrant /srv

echo "revising PHP file upload size"
sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 128M/g' /etc/php.ini

grep -q "relayhost = 192.168.1.49" /etc/postfix/main.cf || echo "Set the SMTP Relay Host"
grep -q "relayhost = 192.168.1.49" /etc/postfix/main.cf || echo "relayhost = 192.168.1.49" >> /etc/postfix/main.cf

#Keep the system up to date
yum -y update

#Installing Git & SVN
sudo yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
sudo yum install -y gcc perl-ExtUtils-MakeMaker
cd /usr/src
sudo wget https://www.kernel.org/pub/software/scm/git/git-2.0.4.tar.gz
sudo tar xzf git-2.0.4.tar.gz
cd /usr/src
sudo make prefix=/usr/local/git all
sudo make prefix=/usr/local/git install

echo 'export PATH=$PATH:/usr/local/git/bin' >> ~/.bashrc
source ~/.bashrc
sudo yum -y install git-svn

#Install Node
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
yum install -y nodejs

#Install Global Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin --filename=composer



# Drupal 8 Installation
sudo mkdir -p /var/www/drupal
sudo yum install mod_ssl

#Install configuration file
sudo cp /vagrant/Scripts/drupal.conf /etc/httpd/conf.d/

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

    #package manager and update the angular app
    npm install -g bower
    cd /vagrant/AngularApp
    sudo npm install

    #Copy information over to the html directory
    sudo ln -fs /vagrant/Drupal8Ang/ /var/www/html/

    # Note: The /etc/httpd/conf/httpd.conf should never be revised, this is controlled by yum/rpm/updates.
    # Note: Place the project specific configuration in the /etc/httpd/conf.d/ directory

    # RHEL/CentOS 7 uses systemctl.  service and /etc/init.d/* were deprecated.
    systemctl restart httpd

    cd /home/vagrant/Drupal8Ang

    sudo /usr/local/bin/drush  si standard -y --account-name=admin --account-pass=admin --db-url=mysql://root@localhost/COneDev --site-name=Cable_One
    # Module Setup
    sudo /usr/local/bin/drush  en -y hal rest serialization basic_auth
}
echo "Drupal Setup Complete"

