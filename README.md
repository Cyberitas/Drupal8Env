Drupal8VM
=========

Vagrant Druapl8 VM (codename Druprant) - Drew-puh-rant

This dev VM spins up a Headless Drupal 8 variant installation with Angular2 and JBoss all packaged in a CentOS environment.

Requires Vagrant, Git, and VirtualBox

http://www.vagrantup.com/downloads <br />
http://git-scm.com/downloads <br />
https://www.virtualbox.org/wiki/Downloads <br />

General commands are:
Run Git Bash as Admin
```
git clone https://github.com/Cyberitas/Drupal8Env
cd Drupal8Env 
vagrant up 

vagrant ssh
```
<br />

The Website folder in your git repo will be where we keep the Core Drupal code.

Open up a web browser and navigate to http://localhost:4567/Website/ this will take you to your Drupal 8 Site

Notes for our current setup:

The mysql username/password is root and an empty password.