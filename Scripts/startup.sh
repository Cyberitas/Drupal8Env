#!/usr/bin/env bash

# mkdir /srv/SharedStorage
chown -R vagrant:vagrant /srv

#Keep the system up to date
yum -y update

# Install PHP, unzip
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
sudo yum install -y php55w php55w-opcache
sudo yum install -y unzip

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

#Installing NginX
sudo yum install -y epel-release
sudo yum install -y nginx
sudo systemctl start nginx

#Http and https firewall traffic allowancee
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

#Installing ElasticSearch


# bump up PHP file upload size
sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 128M/g' /etc/php.ini

# This is mostly for jnutt's benefit
cp /vagrant/Scripts/rxvt-unicode-256color /usr/share/terminfo/r/


echo "Install JBoss"
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
    npm install -g bower

    #Initializing angular drupal start
    git svn clone https://svn.cyberitas.com:18080/svn/CableOne/trunk  AngularApp
    sudo npm install

    # Import angular theme and modules (Cyberitas only)

    # Move things around as needed

    #Database import

    sudo ln -fs /vagrant/Drupal8Ang/ /var/www/html/
    sudo cp -r /vagrant/cyberitas/ /vagrant/Drupal8Ang/profiles/

    cd /home/vagrant/Drupal8Ang

    sudo /usr/local/bin/drush  si standard -y --account-name=admin --account-pass=admin --db-url=mysql://root@localhost/COneDev --site-name=Cable_One
    # Module Setup
    sudo /usr/local/bin/drush  en -y hal rest serialization basic_auth
}
echo "Drupal Setup Complete"