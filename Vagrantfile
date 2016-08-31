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
      end
      puts "Note: "
      puts "      cygwin shell must be run as Administrator"
      puts "      Your .bashrc must contain these:"
      puts "          export CYGWIN=winsymlinks:native"
      puts "          export VAGRANT_DETECTED_OS=cygwin"
      puts ""
   elsif OS.mac?
      puts "Host OS is Mac"
   else
      puts "Host OS is not Windows or Mac"
   end

   # Using the Cyberitas CentOS 7 distro, IUS PHP 5.6, MySql 5.7 Community.
   config.vm.box = "cyberitas/centos7-LAMP"
   config.vm.box_url = "http://artifact.cyberitas.com/StaticProvisioning/centos7-LAMP.box"

   # Setting our network configruations, be sure to change the hostname relative to the needed project
   config.vm.network "private_network", ip: "192.168.37.10"
   config.vm.hostname = "drupal8.development.cyberitas.com"
   # Are these port forwards needed for Drupal 8 development?
   config.vm.network :forwarded_port, host: 4567, guest: 80
   config.vm.network :forwarded_port, host: 1080, guest: 1080
   config.ssh.forward_agent = true

   if OS.windows?
      puts "Windows not using nfs"
      config.vm.synced_folder ".", "/vagrant"
   elsif OS.mac?
      # mac can use nfs.
      # puts "Mac uses nfs"
      # config.vm.synced_folder ".", "/vagrant", type: "nfs", mount_options: ['actimeo=1']
      config.vm.synced_folder ".", "/vagrant"
   else
      config.vm.synced_folder ".", "/vagrant"
   end

   config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      # Improve timesync
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", "500"]
      vb.name = "Drupal8_web_app"
   end

   puts "Installing commands (requires 'vagrant plugin install vagrant-exec')"
   puts "Executing Provisioning: Scripts/provision-vagrant.sh"
   config.vm.provision :shell, path: "Scripts/provision-vagrant.sh"
end
