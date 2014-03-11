# Security Simulator
#
# $Id$
#
# $Revision$
#
# This program allows you to use a large amount of virtual machines and install vulnerable software to create a learning environment.
#
# By: Lewis Ardern (Leeds Metropolitan University)

require 'getoptlong'
require 'fileutils'
#require_relative 'lib/xml/xmllist.rb'
#require_relative 'lib/xml/solution.rb'
require_relative 'system.rb'
require_relative 'VagrantFileCreator.rb'
#require ''

 ips = File.open('lib/commandui/logo/logo.txt', 'r') do |f1|  
  while line = f1.gets
    puts line  
    end  


def usage
  puts 'Usage: 

   run - creates virtual machines e.g run 10

   kill - destoys current session

   ssh - creates a ssh session for specifiec box e.g ssh box1 

   All options options are:
   --help -h: show 
   --run -r: run
'
  exit
end

def run
	puts 'reading configuration file on how many virtual machines you want to create'
	#create new directory for virtual machines
	#look into ruby command
	#system  'mkdir /Users/lewisardern/Documents/security-simulator/projects/CTFv2/ '
	#system  'cd /Users/lewisardern/Documents/security-simulator/projects/CTFv2/ '

	puts 'spinning up virtual machines'
	puts 'creating vagrant file'
	systems = []
 
  doc = Nokogiri::XML(File.read(BOXES_DIR))
  doc.xpath("//systems/system").each do |system|
    id = system["id"]
    os = system["os"]
    base = system["basebox"]
    vulns = system.css('vulnerabilities vulnerability').collect do |v| 
       { 'privilege' => v['privilege'], 'access' => v['access'], 'type' => v['type'] } 
      end
      
    networks = system.css('networks network').collect { |n| n['name'] }
 
    systems << System.new(id, os, base, vulns, networks)
  end
  create_vagrant = VagrantFileCreator.new
  test = []
  create_vagrant.generate(test)

	#createVagrantFile

	puts 'installing vulnerabilities...'
end

def config
	usage
end

opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--run', '-r', GetoptLong::NO_ARGUMENT ],
  [ '--config', '-c', GetoptLong::NO_ARGUMENT ]
)

opts.each do |opt, arg|
  case opt
    when '--help'
      usage
    when '--run'   
    	run
    when '--config'  
    	#do a box count increment to next one
    	#create template config file!
    	config
      end 
  end
end



