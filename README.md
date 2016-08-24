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

Some notes on creating routes (views) 

First: Create a new view of the content you wish to display, define it under "Rest Export Settings". http://localhost:4567/Drupal8Ang/admin/structure/views/add
Second: Create a content type with fields that'll be the approximation of what you want to pass via the REST API. http://localhost:4567/Drupal8Ang/admin/structure/types    
Third (Optional) Change permissions on the content type to allow users to modify data (as anonymous) http://localhost:4567/Drupal8Ang/admin/people/permissions