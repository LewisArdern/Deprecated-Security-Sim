#Script that downloads and installs DVWA onto a box, will check to see if required software is already there.

puts "#######################################"
puts "# Damn Vulnerable Web App Installer Script #"
puts "########################################"

#update server
exec "sudo apt-get -y update"

#Check to see if webserver is installed
exec "sudo apt-get -y install apache2 php5 libapache2-mod-php5"
exec "sudo service apache2 restart"

#Check to see if sqlserver is installed
exec "sudo apt-get install mysql-server mysql-client"
exec "sudo mysqladmin -u root -h localhost password 'password'"
exec "sudo apt-get install php5-mysql"









#Check if cleanup is specified in config 