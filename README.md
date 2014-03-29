
Security-Simulator 
==
Security Simulator is released under a BSD-style license. 

The latest version of this software is available from

Summary
--

Security Simulator is a ruby application developed by Lewis Ardern for his Final Year Project that uses virtualization software to automatically create vulnerable virtual machines so students can learn security penetration testing techniques. 

Boxes like Metasploitable2 are always the same, this project uses Vagrant, Puppet, and Ruby to create vulnerable virtual machines quickly that can be used for learning or CTF events. 

Installing
--
For now you will need to install the following:

Vagrant: http://www.vagrantup.com/
Ruby: https://www.ruby-lang.org/en/
Nokogiri: http://nokogiri.org/tutorials/installing_nokogiri.html
Puppet is not required on your local machine, the boxes that you use will need to have puppet installed on them the main box used has been from puppetlabs: http://puppet-vagrant-boxes.puppetlabs.com/centos-59-x64-vbox4210.box

Testing
--
While creatng this application I used the following:

OSx Version 10.8.5
Vagrant 1.5.0
nokogiri (1.6.1)
ruby 2.0.0p195 (2013-05-14 revision 40734) [x86_64-darwin12.5.0]

It should work on most linux distros but if there are any problems contact me.

Usage
--
Currently there is no user interface, so you will need to modify the XML to create virtual machines. To run the default-setup all you need to do is:

ruby securitysimulator.rb -r  this will create you a new project in /projects and will create a Vagrant File / Report for you to view and see what has been installed, this will also give you a feel for how Vagrant spins up virtual machines. 

Creating Addtional boxes and vulnerabilities
--

if you want to create additional boxes, vulnerabilities, refer to lib/xml

you need to modify boxes.xml to add additional boxes to build 

vulns.xml has the known vulnerabilities that you can currently build with this project, you can either specify them or leave it blank and it will automatically generate one for you.

bases.xml have to known boxes that have bases however 'puppettest' was used to create everything which is based on CentOS. http://www.vagrantbox.es has a list of working boxes that you can download.

networks.xml has the known ranges for this project, the ip is currently modified in lib/templates/vagrantbase.erb on line 17.

Demo
--
If you look under the projects folder there is Project1, if you go into this folder and write 'vagrant up' you will see how the process works. 'Video will be created to explain this further', but will be a good first step in understanding how the project works.

Contributing
--
If you like the idea of Security Simulator, you are more than welcome to commit to the project.

