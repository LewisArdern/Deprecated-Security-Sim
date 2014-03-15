require 'nokogiri'
ROOT_DIR = File.dirname(__FILE__)

BOXES_DIR = "#{ROOT_DIR}/lib/xml/boxes.xml"
NETWORKS_DIR = "#{ROOT_DIR}/lib/xml/networks.xml"
VULNS_DIR = "#{ROOT_DIR}/lib/xml/vulns.xml"
BASE_DIR = "#{ROOT_DIR}/lib/xml/bases.xml"

class System
    # can access from outside of class 
    attr_accessor :id, :os, :basebox

	#initalizes system variables
    def initialize(id, os, basebox, vulns=[], networks=[])
        @id = id
        @os = os
        @basebox = basebox

        @data = {
         "vulns" => vulns,
         "networks" => networks  
        }
    end

    def list_vulns 	
		return get_valid("vulns", Conf.vulnerabilities, "type")
	end

    def list_networks    
        return get_valid("networks", Conf.networks, "name")
    end

    def get_valid(id, valid_items, key)
        known_item = []

        @data[id].each do |item|
            # boolean to check if valid type matches vuln type etc
            valid_items.each do |valid|
                if item.send(key) == valid.send(key)
                    known_item << item
                    break 
                end
            end
        return known_item
        end
    end

    def add_vuln

    end
    
    def is_valid_base
        valid_base = Conf.bases

        valid_base.each do |b|
            if @basebox == b.vagrantbase
                return true
            end
        end
        return false
    end
end


class Network
    attr_accessor :name, :range
end
class Basebox
    attr_accessor :name, :os, :distro, :vagrantbase, :url
end
class Vulnerability
    attr_accessor :type, :privilege, :access ,:puppet, :details

    def initialize(type=nil, privilege=nil, access=nil, puppet=nil, details=nil)

        @type = type
        @privilege = privilege
        @access = access
        @puppet = puppet
        @details = details
    end
end
 
class Conf
    def self.networks
        if defined? @@networks
            return @@networks
        end
        return @@networks = self._get_list(NETWORKS_DIR, "//networks/network", Network)
    end
 
    def self.bases
        if defined? @@bases
            return @@bases
        end
        return @@bases = self._get_list(BASE_DIR, "//bases/base", Basebox)
    end
 
    def self.vulnerabilities
        if defined? @@vulnerabilities
            return @@vulnerabilities
        end
        return @@vulnerabilities = self._get_list(VULNS_DIR, "//vulnerabilities/vulnerability", Vulnerability)
    end
 
    def self._get_list(xmlfile, xpath, cls)
        itemlist = []
        
        doc = Nokogiri::XML(File.read(xmlfile))
        doc.xpath(xpath).each do |item|
        	obj = cls.new
            item.each do |attr, value|
                obj.send "#{attr}=", value
            end
            itemlist << obj
        end
        return itemlist
        
    end
end