# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

   module OS
       def OS.windows?
           (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
       end

       def OS.mac?
           (/darwin/ =~ RUBY_PLATFORM) != nil
       end

       def OS.unix?
           !OS.windows?
       end

       def OS.linux?
           OS.unix? and not OS.mac?
       end
   end

   if OS.windows?
      puts "Host OS is Windows"
      puts "Enabling SymlinksCreate"
      config.vm.provider "virtualbox" do |v|
         v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
         v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant_dbsrc", "1"]
      end
      puts "Note: "
      puts "      cygwin shell must be run as Administrator"
      puts "      Your .bashrc must contain these:"
      puts "          export CYGWIN=winsymlinks:native"
      puts "          export VAGRANT_DETECTED_OS=cygwin"
      puts ""
   elsif OS.mac?
      puts "Host OS is Mac"
   end

   # The most common configuration options are documented and commented below.
   # For a complete reference, please see the online documentation at
   # https://docs.vagrantup.com.

   # Every Vagrant development environment requires a box. You can search for
   # boxes at https://atlas.hashicorp.com/search.
   #config.vm.box = "bento/centos-6.7"
   config.vm.box = "cyberitas/centos6_x86_64-LAMP"
   config.vm.box_url = "http://artifact.cyberitas.com/StaticProvisioning/centos6_x86_64-LAMP.box"

   # Disable automatic box update checking. If you disable this, then
   # boxes will only be checked for updates when the user runs
   # `vagrant box outdated`. This is not recommended.
   # config.vm.box_check_update = false

   # Create a forwarded port mapping which allows access to a specific port
   # within the machine from a port on the host machine. In the example below,
   # accessing "localhost:8080" will access port 80 on the guest machine.
   # config.vm.network "forwarded_port", guest: 80, host: 8080

   # Create a private network, which allows host-only access to the machine
   # using a specific IP.
   config.vm.network "private_network", ip: "192.168.34.10"
   config.vm.hostname = "cbcworldwide.development.cyberitas.com"

   # Create a public network, which generally matched to bridged network.
   # Bridged networks make the machine appear as another physical device on
   # your network.
   # config.vm.network "public_network"

   # Share an additional folder to the guest VM. The first argument is
   # the path on the host to the actual folder. The second argument is
   # the path on the guest to mount the folder. And the optional third
   # argument is a set of non-required options.
   # config.vm.synced_folder "../data", "/vagrant_data"

   if OS.windows?
       puts "Windows not using nfs"
       config.vm.synced_folder ".", "/vagrant"
   elsif OS.mac?
       puts "Mac uses nfs"
       config.vm.synced_folder ".", "/vagrant", type: "nfs", mount_options: ['actimeo=1']
   end

   config.vm.synced_folder ".", "/vagrant"

   # config.vm.synced_folder "../DatabaseServer", "/vagrant_dbsrc"

   # Provider-specific configuration so you can fine-tune various
   # backing providers for Vagrant. These expose provider-specific options.
   # Example for VirtualBox:
   #
   config.vm.provider "virtualbox" do |vb|
   #   # Display the VirtualBox GUI when booting the machine
   #   vb.gui = true
   #
   #   # Customize the amount of memory on the VM:
      vb.memory = "4096"
       # Improve timesync
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", "500"]
      vb.name = "CBC_web_app_serveraeouaeouaoeu"
   end
   #
   # View the documentation for the provider you are using for more
   # information on available options.

   # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
   # such as FTP and Heroku are also available. See the documentation at
   # https://docs.vagrantup.com/v2/push/atlas.html for more information.
   # config.push.define "atlas" do |push|
   #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
   # end

   puts "Installing commands (requires 'vagrant plugin install vagrant-exec')"
   # Install the vagrant-exec plugin (`vagrant plugin install vagrant-exec`)
   # or use the binstubs in bin/ to run these commands within the Vagrant machine
   config.exec.commands "ant", directory: "/vagrant"
   # config.exec.commands "grunt", directory: "/vagrant/CdnSite"
   # config.exec.commands "phpunit", directory: "/vagrant/BrokerSites/Website/src/tests"
   config.exec.commands "httpd", prepend: "sudo service"

   # Enable provisioning with a shell script. Additional provisioners such as
   # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
   # documentation for more information about their specific syntax and use.
   config.vm.provision "shell", inline: <<-SHELL
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
      cp /vagrant/VagrantScripts/rxvt-unicode-256color /usr/share/terminfo/r/

      # copy the location files for the cache server
      mkdir -p /srv/spool/cbcww_cache
      cp /vagrant/CacheServer/Data/location.xml /srv/spool/cbcww_cache
      cp /vagrant/CacheServer/Data/locationzipintersection.xml /srv/spool/cbcww_cache

      cd /vagrant/WebServer
      sudo -u vagrant /usr/local/bin/ant install
      cd

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
      cd /vagrant/DatabaseServer/Initialize/
      echo "Creating MySQL databases and users."
      cat create-cbc-databases.sql | mysql -uroot
      cat create-cbc-users.sql     | mysql -uroot

      echo "Loading solo_cbc MySQL test database."
      zcat test_data/solo_cbc_developer.sql.gz | mysql -uadmin -pWhx263hytc solo_cbc

      echo "Loading MySQL feed database."
      bash ./initialize-feeds.sh

      echo "Creating MySql functions and procedures."
      bash ./initialize-procedures.sh

      echo "Loading REIS."
      cat test_data/load-reisquarterly.sql | mysql -uadmin -pWhx263hytc feeds

      echo "Creating cbc database with liquibase."
      cd /vagrant/DatabaseServer
      sudo -u vagrant /usr/local/bin/ant install

      echo "Loading MySQL Developer Test Data"
      cd /vagrant/DatabaseServer/Initialize/
      bash ./load-test-data.sh

      echo "SMTP Set Relay Host"
      echo "relayhost = 192.168.1.49" >> /etc/postfix/main.cf

      adduser cbc

      cd ${IWASHERE}

   SHELL

   # drop some configs for cyberedge to play with
   config.vm.provision "shell", inline: <<-SHELL
      mkdir -p /etc/cyberedgedaemon.d
      cp /vagrant/CacheServer/conf/cyberedge/development/cyberedge-cbcww.conf /etc/cyberedgedaemon.d
      cp /vagrant/BlueprintWebServer/conf/cyberedge/shared/blueprint.conf /etc/cyberedgedaemon.d
   SHELL

   # install and start cyber edge
   config.vm.provision "shell", path: "VagrantScripts/cyberEdge.sh"

   # install our CyberEdge-dependent application software
   config.vm.provision "shell", inline: <<-SHELL
      cd /vagrant/CacheServer
      make deploy
   SHELL

   # install PhP to Oracle database bridge
   config.vm.provision "shell", path: "VagrantScripts/phpToOracle.sh", args: "-c"

   # install SIML for legacy Blueprint
   config.vm.provision "shell", path: "VagrantScripts/nopSmartSystems.sh"

   # install Blueprint
   config.vm.provision "shell", inline: <<-SHELL
      cd /vagrant/BlueprintWebServer
      sudo -u vagrant /usr/local/bin/ant install
   SHELL

   # Dropbox integration
   config.vm.provision "shell", inline: <<-SHELL
      echo "Integrating Dropbox storage for /web/media/sites"
      ( cd /home/vagrant; wget --no-verbose -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - )
      cd /home/vagrant
      tar zxf /vagrant/VagrantScripts/cbc-dropbox-snapshot.tgz
      sudo chmod 755 /home /home/vagrant 
      sudo chmod 777 /home/vagrant/Dropbox /home/vagrant/Dropbox/sites
      sudo chmod g+s /home/vagrant/Dropbox/sites
      sudo mkdir /web
      sudo chmod 777 /web
      sudo chown vagrant:vagrant /web
      sudo chmod g+s /web
      mkdir /web/media
      cd /web/media
      ln -s /home/vagrant/Dropbox/sites
      cd /home/vagrant
      echo "Starting Dropbox.."
      nohup /home/vagrant/.dropbox-dist/dropboxd > /home/vagrant/.dropbox.log 2>&1 &
      echo "Scheduling Dropbox to start with 'vagrant up'.."
      CRONSCRATCH=$(mktemp)
      echo '@reboot cd /home/vagrant; nohup /home/vagrant/.dropbox-dist/dropboxd > /home/vagrant/.dropbox.log 2>&1 &' > $CRONSCRATCH
      sudo cat $CRONSCRATCH > /var/spool/cron/vagrant
      rm -f $CRONSCRATCH
      sudo chown vagrant:vagrant /var/spool/cron/vagrant
      sudo chmod 400 /var/spool/cron/vagrant
   SHELL


end
