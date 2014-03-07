require 'nokogiri'
require 'tempfile'
require 'fileutils'

System = Struct.new(:os, :base, :number, :vulnerability, :networks)

def read_systems_xml
    filename = "/Users/lewisardern/Documents/Security-Simulator/lib/xml/boxesconfig.xml"
    doc = Nokogiri::XML(File.open(filename))

    doc.search('//systems/system').map do |system|
    System.new(
      system.at('@os').text, 
      system.at('@basebox').text, 
      system.at('@number').text,
      system.css('vulnerabilities vulnerability').collect do |vulnerability| 
	    { 'critical' => vulnerability['critical'], 'access' => vulnerability['access'] } 
    end,
	 system.css('networks network').collect do |network| 
	    { 'network' => network['name'] } 
	end)
    end
end