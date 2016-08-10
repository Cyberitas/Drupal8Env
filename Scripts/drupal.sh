#!/usr/bin/env bash

# Drush Time
if drush version; then
  echo "Drush already installed"
else
    # Download latest stable release using the code below or browse to github.com/drush-ops/drush/releases.
    php -r "readfile('http://files.drush.org/drush.phar');" > drush
    # Or use our upcoming release: php -r "readfile('http://files.drush.org/drush-unstable.phar');" > drush

    # Test your install.
    php drush core-status

    # Make `drush` executable as a command from anywhere. Destination can be anywhere on $PATH.
    chmod +x drush
    sudo mv drush /usr/local/bin
fi

echo "Please wait while Drupal is downloading..."

cd ../
drush dl drupal

mv ./drupal-8.1.8 ./WebSite

cd ./WebSite

