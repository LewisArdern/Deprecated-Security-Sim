#Script that downloads and installs DVWA onto a box, will check to see if required software is already there.

require 'tempfile'
require 'fileutils'

puts "#######################################"
puts "# Damn Vulnerable Web App Installer Script #"
puts "########################################"

#Update security on the box 
puts "updating the box to the latest patch"
%x{ "sudo apt-get -y update"}

#Check to see if webserver is installed
puts "installing webserver"
%x{ "sudo apt-get -y install apache2 php5 libapache2-mod-php5"}
%x{ "sudo service apache2 restart"}

#Check to see if sqlserver is installed
puts "install mysql"
%x{ "sudo apt-get -y install mysql-server mysql-client"}
%x{ "sudo mysqladmin -u root -h localhost password 'password'"}
%x{ "sudo apt-get -y install php5-mysql"}


%x{cd /tmp/}
puts "Checking to see if DVWA is currently installed on the box"

#check to see if dvwa is installed on /var/www if not download and unzip 

%x{wget https://github.com/RandomStorm/DVWA/archive/v1.0.8.zip}


%x{sudo apt-get -y install unzip}

%x{sudo unzip v1.0.8.zip}

%x{sudo rm /var/www/index.html}

%x{sudo mv DVWA-1.0.8/ /var/www/}

%x{sudo cp /var/www/config/config.inc.php /var/www/config/config.inc.php1}

%x{cd var/www/config}

#write a ruby app to read the line in and edit it or if its easier just modify specific line
%x{cp config.inc1.php config.inc.php}

path = '~/Documents/Security\ Simulator/config/dvwa.config'
temp_file = Tempfile.new('foo')
begin
  File.open(path, 'r') do |file|
    file.each_line do |line|
    	next if line.match(/$_DVWA[ 'db_password' ] =/)
    	{
    		line = "$_DVWA[ 'db_password' ] = 'PasswordFromConfigurationFile';"
    	}
      temp_file.puts line
    end
  end
  temp_file.rewind
  FileUtils.mv(temp_file.path, path)
ensure
  temp_file.close
  temp_file.unlink
end

%x{}



#Check if cleanup is specified in config 