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

   config.vm.provision :shell, path: "VagrantScripts/bootstrap.sh"
end
