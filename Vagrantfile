# -*- mode: ruby -*-
# vi: set ft=ruby :

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

   # Using the Cyberitas Redhat distro
   config.vm.box = "cyberitas/centos6_x86_64-LAMP"
   config.vm.box_url = "http://artifact.cyberitas.com/StaticProvisioning/centos6_x86_64-LAMP.box"

   # Setting our network configruations, be sure to change the hostname relative to the needed project
   config.vm.network "private_network", ip: "192.168.34.10"
   config.vm.hostname = "drupal8.development.cyberitas.com"

   if OS.windows?
       puts "Windows not using nfs"
       config.vm.synced_folder ".", "/vagrant"
   elsif OS.mac?
       puts "Mac uses nfs"
       config.vm.synced_folder ".", "/vagrant", type: "nfs", mount_options: ['actimeo=1']
   end

   config.vm.synced_folder ".", "/vagrant"

   config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
       # Improve timesync
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", "500"]
      vb.name = "Drupal8_web_app_serveraeouaeouaoeu"
   end

   puts "Installing commands (requires 'vagrant plugin install vagrant-exec')"

   config.exec.commands "ant", directory: "/vagrant"
   config.exec.commands "httpd", prepend: "sudo service"


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

   SHELL

end
