require 'nokogiri'
ROOT_DIR = File.dirname(__FILE__)

BOXES_DIR = "#{ROOT_DIR}/lib/xml/boxes.xml"
NETWORKS_DIR = "#{ROOT_DIR}/lib/xml/networks.xml"
VULNS_DIR = "#{ROOT_DIR}/lib/xml/vulns.xml"
BASE_DIR = "#{ROOT_DIR}/lib/xml/bases.xml"

class System
	attr_reader :id, :os, :base, :vulns, :networks

	#initalizes system variables
    def initialize(id, os, base, vulns=[], networks=[])
        @id = id
        @os = os
        @base = base
        @vulns = vulns
        @networks = networks
    end

    def list_vulns 	
    	known_vulns = []
    	valid_vulns = Conf.vulnerabilities

        # this method will loop through and check if type equals to
        # type that is currently set in boxes.xml
        @vulns.each do |vuln|
		  	# boolean to check if valid type matches vuln type etc
		  	valid_vulns.each do |valid|
		  		if vuln.type == valid.type
		  			known_vulns << vuln 
		  			break
		  		end
		  	end
		end
		return known_vulns
	end
 
    def networks
        valid_networks = Conf.networks
 
        # compare @networks with valid_networks and construct a list
        # of networks that are legal.
    end
 
    def bases
        valid_bases = Conf.bases
 
        # compare @bases with valid_bases and construct a list
        # of bases that are legal.
    end
 
    # it'd be a good idea to move the comparison process into a helper method.
    # self._get_list, inside the Conf class, is a good example of what I mean.
end

class Network
    attr_accessor :name, :range
end
class Basebox
    attr_accessor :name, :os, :distro, :vagrantbase
end
class Vulnerability
    attr_accessor :type, :privilege, :access ,:puppet, :details
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