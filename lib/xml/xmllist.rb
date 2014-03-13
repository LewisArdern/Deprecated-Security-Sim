require 'nokogiri'
require 'tempfile'
require 'fileutils'


# class System
#   attr_accessor :os, :base, :number, :vulnerability, :network
# end

# class Vulnerability
#   attr_accessor :type, :puppet, :details
# end

# class Base
#   attr_accessor :name, :os, :distro, :base
# end

# class Network
#   attr_accessor :name, :range
# end

# systems = {}
# bases = {}

# class BaseManager
#   @bases = []

#   def self.is_known_base?(basename)
#     @bases.each do |base|
#       if base.name == basename
#         return true
#       end
#     end
#     return false
#   end
# end

# class SystemManager
#   @systems = []

#   def self.list_systems_with_bases(is_known)
#     sys_list = []
#     @systems.each do |sys|
#       known = BaseManager.is_known_base?(sys.base)
#       if is_known ? known : not known
#         sys_list << sys
#       end
#     end

#     return sys_list
#   end
# end

def read_systems_xml
  systems = []

  filename = "#{ROOT_DIR}/../../lib/xml/boxes.xml"
    doc = Nokogiri::XML(File.open(filename))

    doc.search('//systems/system').map do |s|
    
      system = {}

      system[:os] = s.at('@os').text
      system[:base] = s.at('@basebox').text
      system[:number] = s.at('@number').text
       
      system[:vulnerability] = s.css('vulnerabilities vulnerability').collect do |v| 
       { 'critical' => v['critical'], 'access' => v['access'] } 
      end
      system[:network] = s.css('networks network').collect { |n| n['name'] }

    systems << system
  end
  return systems
end

def read_network_xml
  networks = []

  filename = "#{ROOT_DIR}/../../lib/xml/networks.xml"
    doc = Nokogiri::XML(File.open(filename))

    doc.search('//networks/network').map do |n|
    
    network = {}
    network[:name] = n.at('@name').text
    network[:range] = n.at('@range').text

    networks << network
  end
  return networks
end



def read_vulns_xml
  vulnerabilities = []

  filename = "#{ROOT_DIR}/../../lib/xml/vulns.xml"
  doc = Nokogiri::XML(File.open(filename))

  doc.search('//vulnerabilities/vulnerability').map do |v|

  vulnerability = {}

  vulnerability[:type] = v.at('@type').text
  vulnerability[:puppet] = v.at('@puppet').text
  vulnerability[:details] = v.at('@details').text

  vulnerabilities << vulnerability
  end
  return vulnerabilities
end

def read_bases_xml
  bases = []

  filename = "#{ROOT_DIR}/../../lib/xml/bases.xml"
  doc = Nokogiri::XML(File.open(filename))

  doc.search('//bases/base').map do |b|

  base = {}
  base[:name] = b.at('@name').text 
  base[:os] = b.at('@os').text
  base[:distro] = b.at('@distro').text
  base[:base] = b.at('@vagrantbase').text
  bases << base
  end
  return bases
end
