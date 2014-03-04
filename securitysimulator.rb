# Security Simulator
#
# $Id$
#
# $Revision$
#
# This program allows you to use a large amount of virtual machines and install vulnerable software to create a learning environment.
#
# By: Lewis Ardern (Leeds Metropolitan University)

#require ''
#require ''

class BaseConsole

 ips = File.open('lib/commandui/logo/logo.txt', 'r') do |f1|  
  while line = f1.gets
    puts line  
    end  

puts "Usage: " if ARGV[0].nil?
puts "	run - creates virtual ex " if ARGV[0].nil?
puts "	kill - destroys session" if ARGV[0].nil?
puts "	ssh - creates an ssh session" if ARGV[0].nil?
puts "	--configure - allows configuration" if ARGV[0].nil?


user_input = ARGV[0]

#if user_input.include? 'vagrant'
#find out how to write full blown commands 0.o
	exec user_input
#end 

#create a file and update the configuration 


end
end
