#Script that downloads and installs DVWA onto a box, will check to see if required software is already there.

puts "#######################################"
puts "# Damn Vulnerable Web App Installer Script #"
puts "########################################"

#Check to see if SQL server is installed, if not install one.

puts "Moving to /var/www"
directory = "/var/ww/"
def directory_exists?(directory)
  File.directory?(directory)
  puts "/var/www does not exist, creating5 /var/www"
  mkdir 
end
exec "cd /var/www"
puts "Done!"

exec "wget https://github.com/RandomStorm/DVWA/archive/v1.0.8.zip"

exec "unzip v1.0.8.zip"