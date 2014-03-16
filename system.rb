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
    def initialize(id, os, basebox, vulns={}, networks={})
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
        end
        return known_item
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

    def initialize(name="", range="")
        @name = range
        @range = range
    end

    def id 
        hash = @name + @range 
        return hash
        # return string that connects everything to 1 massive string
    end

    def eql? other
        other.kind_of?(self.class) && @name == other.name
    end
    
    def hash
        @type.hash
    end
end

# class NetworkManager
#     # the user will either specify a blank vulnerability type due to specifying A vulnerability
#     # or they will specify a type, for the demo if the type hasn't been spelled correctly then its for the user to fix
#     # logic will be put in place to give some form of error handling 
#     # it also needs to report to the user what kind of vulnerabilities are being made for each host.. 
#     def self.process(network,valid_networks)
#         new_networks = {}
#         networks.each do |network|
#               if network.name == ""
#                 valid_random = get_random_valid
#                 network.name = valid_random.name
#                 new_networks.range = valid_random.range 
#                 new_vulns[network.id] = network
#                 break
#              else valid_networks.each do |valid|    
#                 if network.name == valid.name
#                     network.range = valid.range
#                     new_networks[vuln.id] = network
#                     break
#                 end

#             end
#         end
#         return new_networks
#     end
# end
#    def get_random_valid_networks(networks)
#         # maybe add in check of array to see if it alreayd exists here 
#         intersection = []
#         valid =  Conf.networks
#         network = valid.sample 
#         return network 
#     end
class Basebox
    attr_accessor :name, :os, :distro, :vagrantbase, :url
end

class Vulnerability
    attr_accessor :type, :privilege, :access ,:puppet, :details

    def eql? other
        other.kind_of?(self.class) && @type == other.type
    end
    
    def hash
        @type.hash
    end

    def initialize(type="", privilege="", access="", puppet="", details="")

        @type = type
        @privilege = privilege
        @access = access
        @puppet = puppet
        @details = details
    end

    def id 
        hash = @type + @privilege + @access + @puppet + @details
        return hash
        # return string that connects everything to 1 massive string
    end
end

class VulnerabilityManager
    # the user will either specify a blank vulnerability type due to specifying A vulnerability
    # or they will specify a type, for the demo if the type hasn't been spelled correctly then its for the user to fix
    # logic will be put in place to give some form of error handling 
    # it also needs to report to the user what kind of vulnerabilities are being made for each host.. 
    def self.process(vulns,valid_vulns)
        new_vulns = {}
        vulns.each do |vuln|
            if vuln.type == ""
                valid_random = self.get_random_valid(vulns,valid_vulns)
                vuln.type = valid_random.type
                vuln.puppet = valid_random.puppet 
                new_vulns[vuln.id] = vuln
                break
            else 
                valid_vulns.each do |valid|    
                    if vuln.type == valid.type
                        vuln.puppet = valid.puppet
                        new_vulns[vuln.id] = vuln
                        break
                    end
                end
            end
        end
        return new_vulns
    end

    #loop through vulns, fill in missing details if not enough info, choose one at random fill in vulns.. 


    def self.get_random_valid(vulns,valid_vulns)
      intersection =  (valid_vulns & vulns)
      return intersection.sample
    

# 1. make intersection vulns, valid vulns
# 2. make dictionary of vulnerabilities, key type and due to nature if assign value to a key owl, owl, override
# check intersection for duplicates
# 3. if 2 succeeds pick random 1 from intersection 

        #intersection of list of networks and list of valid networks pick random 
        # single out the one replacing on the intersecton of networks and valid networks 
        # summaries: start with list a / b networks, list of valid networks a,b,c intersection will just be a and b 
        # single out network replacing lets say a is generic type, none specific singling that one out 
        # extract from list intersection is only b, then loop through that intersection to make sure to no duplicates of a
        
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