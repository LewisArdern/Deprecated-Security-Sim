require 'nokogiri'
require 'tempfile'
require 'fileutils'
 
def readXML

doc = Nokogiri::XML(File.open("/Users/lewisardern/Documents/Security-Simulator/lib/xml/boxesconfig.xml"))


doc.search('//systems/system').each do |system|
    systemNumber  = system.at('@number').text
    os  = system.at('//os/@system').text
    base = system.at('//os/@basebox').text
   
  	  vulnerabilities = system.css('vulnerabilities vulnerability').collect do |vulnerability| 
 	  { 'critical' => vulnerability['critical'], 'access' => vulnerability['access'] } 
	end
	  	  networks = system.css('networks network').collect do |network| 
 	  { 'network' => network['name'] } 
	end

    puts vulnerabilities
    puts systemNumber
    puts os
    puts networks    
end
end


def createVagrantFile
out_file = File.new("/Users/lewisardern/Documents/Security-Simulator/projects/CTFv2/VagrantFile", "w")

doc = Nokogiri::XML(File.open("/Users/lewisardern/Documents/Security-Simulator/lib/xml/boxesconfig.xml"))


doc.search('//systems/system').each do |system|
	out_file.puts(system)
    systemNumber  = system.at('@number').text
    os  = system.at('//os/@system').text
    base = system.at('//os/@basebox').text
   
  	  vulnerabilities = system.css('vulnerabilities vulnerability').collect do |vulnerability| 
 	  { 'critical' => vulnerability['critical'], 'access' => vulnerability['access'] } 
	end
	  	  networks = system.css('networks network').collect do |network| 
 	  { 'network' => network['name'] } 
	end
	  
end
out_file.close
end

