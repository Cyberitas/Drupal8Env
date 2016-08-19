#!/usr/bin/env bash

# mkdir /srv/SharedStorage
chown -R vagrant:vagrant /srv

echo "revising PHP file upload size"
sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 128M/g' /etc/php.ini

grep -q "relayhost = 192.168.1.49" /etc/postfix/main.cf || echo "Set the SMTP Relay Host"
grep -q "relayhost = 192.168.1.49" /etc/postfix/main.cf || echo "relayhost = 192.168.1.49" >> /etc/postfix/main.cf

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
    sudo mv ./drupal-8.1.8 /vagrant/Website/
    sudo ln -fs /vagrant/Website/ /var/www/html/
    sudo cp -r /vagrant/cyberitas/ /vagrant/Website/profiles/

    # Have to make some apache changes, maybe we should update our CentOS?
    # sed -i '338d' /etc/httpd/conf/httpd.conf
    # sed -i '338i\AllowOverride All' /etc/httpd/conf/httpd.conf
    # Note: The /etc/httpd/conf/httpd.conf should never be revised, this is controlled by yum/rpm/updates.
    # Note: Place the project specific configuration in the /etc/httpd/conf.d/ directory

    # RHEL/CentOS 7 uses systemctl.  service and /etc/init.d/* were deprecated.
    systemctl restart httpd
    cd /vagrant/Website

    sudo /usr/local/bin/drush  si standard -y --account-name=admin --account-pass=admin --db-url=mysql://root@localhost/C21Database --site-name=C21
}
echo "Drupal Setup Complete"

