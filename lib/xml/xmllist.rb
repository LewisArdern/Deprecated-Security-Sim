require 'nokogiri'
require 'tempfile'
require 'fileutils'

class System
  attr_accessor :os, :base, :number, :vulnerability, :network
end

def read_systems_xml
  systems = []

  filename = "/Users/lewisardern/Documents/Security-Simulator/lib/xml/boxes.xml"
    doc = Nokogiri::XML(File.open(filename))

    doc.search('//systems/system').map do |s|
    
      system = System.new

      system.os = s.at('@os').text
      system.base = s.at('@basebox').text
      system.number = s.at('@number').text
       
      system.vulnerability = s.css('vulnerabilities vulnerability').collect do |v| 
       { 'critical' => v['critical'], 'access' => v['access'] } 
      end
        system.network = s.css('networks network').collect do |n| 
      { 'network' => n['name'] } 
    end
    systems << system
  end
end

class Vulnerability
  attr_accessor :type, :puppet, :details
end

def read_vulns_xml
  vulnerabilities = []

  filename = "/Users/lewisardern/Documents/Security-Simulator/lib/xml/vulns.xml"
  doc = Nokogiri::XML(File.open(filename))

  doc.search('//vulnerabilities/vulnerability').map do |v|

  vulnerability = Vulnerability.new

  vulnerability.type = v.at('@type').text
  vulnerability.puppet = v.at('@puppet').text
  vulnerability.details = v.at('@details').text

  vulnerabilities << vulnerability
  end
end

class Base
  attr_accessor :name, :os, :distro, :vagrantbase
end

def read_bases_xml
  bases = []

  filename = "/Users/lewisardern/Documents/Security-Simulator/lib/xml/bases.xml"
  doc = Nokogiri::XML(File.open(filename))

  doc.search('//bases/base').map do |b|

  base = Base.new
  base.name = b.at('@name').text, 
  base.os = b.at('@os').text,
  base.distro = b.at('@distro').text, 
  base.vagrantbase = b.at('@vagrantbase').text
  bases << base
  end
end
