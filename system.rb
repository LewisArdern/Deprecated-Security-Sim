require 'nokogiri'
ROOT_DIR = File.dirname(__FILE__)

BOXES_DIR = "#{ROOT_DIR}/lib/xml/boxes.xml"
NETWORKS_DIR = "#{ROOT_DIR}/lib/xml/networks.xml"
VULNS_DIR = "#{ROOT_DIR}/lib/xml/vulns.xml"
BASE_DIR = "#{ROOT_DIR}/lib/xml/bases.xml"
MOUNT_DIR = "#{ROOT_DIR}/mount/"
class System
    # can access from outside of class
    attr_accessor :id, :os, :url,:basebox, :networks, :vulns

	#initalizes system variables
    def initialize(id, os, basebox, url, vulns=[], networks=[])
        @id = id
        @os = os
        @url = url
        @basebox = basebox
        @vulns = vulns
        @networks = networks
    end

    def is_valid_base
        valid_base = Conf.bases

        valid_base.each do |b|
            if @basebox == b.vagrantbase
                @url = b.url
                return true
            end
        end
        return false
    end
end


class Network
    attr_accessor :name, :range

    def initialize(name="", range="")
        @name = name
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

class NetworkManager
    # the user will either specify a blank vulnerability type due to specifying A vulnerability
    # or they will specify a type, for the demo if the type hasn't been spelled correctly then its for the user to fix
    # logic will be put in place to give some form of error handling
    # it also needs to report to the user what kind of vulnerabilities are being made for each host..
    def self.process(networks,valid_network)
        new_networks = {}

        legal_networks = valid_network & networks
        networks.each do |network|
            if network.name == ""
                random = valid_network.sample
                # valid vulnerability into a new hash map of vulnerabilities 
                 new_networks[random.id] = random
            else
                has_found = false
                # shuffle randomly selects first match of ftp or nfs and then abandon
                legal_networks.shuffle.each do |valid|
                     if network.name == valid.name
                        network.range = valid.range unless not network.range.empty?
                        # valid vulnerability into a new hash map of vulnerabilities 
                        new_networks[network.id] = network
                        has_found = true
                        break
                     end
                end
                if not has_found
                    p "Network was not found please check the xml boxes.xml"
                    exit
                end
            end
        end
        return new_networks.values
    end


    # def self.sort_network_range(systems)
    #     sorted_networks = []
    #     systems.each do |s|
    #         s.networks.each do |n|
    #             grab_system_number = s.id.gsub(/[^0-9]/i, "")
    #             n.range[9..9] = grab_system_number
    #             sorted_networks << n
    #         end
    #     end
    #     return sorted_networks
    # end
end

class Basebox
    attr_accessor :name, :os, :distro, :vagrantbase, :url
end

class BaseManager
    def self.generate_base(system,bases)
        box = bases.sample
        # p system.basebox
        system.basebox = box.vagrantbase 
        system.url = box.url
    return system
    end
end

class Vulnerability
    attr_accessor :type, :privilege, :access ,:puppets, :details, :ports

    def eql? other
        other.kind_of?(self.class) && @type == other.type
    end

    def hash
        @type.hash
    end

    def initialize(type="", privilege="", access="", puppets=[], details="", ports=[])
        @type = type
        @privilege = privilege
        @access = access
        @puppets = puppets
        @details = details
        @ports = ports
    end

    def id
        return @type + @privilege + @access
    end

end

class VulnerabilityManager
    # the user will either specify a blank vulnerability type due to specifying A vulnerability
    # or they will specify a type, for the demo if the type hasn't been spelled correctly then its for the user to fix
    # logic will be put in place to give some form of error handling
    # it also needs to report to the user what kind of vulnerabilities are being made for each host..
    def self.process(vulns,valid_vulns)
        new_vulns = {}

        
        legal_vulns = valid_vulns & vulns
        p vulns, legal_vulns, valid_vulns
        vulns.each do |vuln|

        if vuln.type == ""
            random = valid_vulns.sample
            # valid vulnerability into a new hash map of vulnerabilities 
            new_vulns[random.id] = random
        else
            has_found = false
            # shuffle randomly selects first match of ftp or nfs and then abandon
            legal_vulns.shuffle.each do |valid|
             if vuln.type == valid.type
                vuln.puppets = valid.puppets unless not vuln.puppets.empty?
                vuln.ports = valid.ports unless not vuln.ports.empty?
                vuln.privilege = valid.privilege unless not vuln.privilege.empty?
                vuln.access = valid.access unless not vuln.access.empty?
                vuln.details = valid.details
                # valid vulnerability into a new hash map of vulnerabilities 
                new_vulns[vuln.id] = vuln
                has_found = true
                break
             end
        end
            if not has_found
                p "vulnerability was not found please check the xml boxes.xml"
                exit
            end
        end
        end
        return new_vulns.values
    end

    #loop through vulns, fill in missing details if not enough info, choose one at random fill in vulns..
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
            # new class e.g networks
        	obj = cls.new
            # checks to see if there are children puppet and add string to obj.puppets
            # move this to vulnerabilities class
            if defined? obj.puppets

                item.xpath("puppets/puppet").each { |c| obj.puppets << c.text.strip if not c.text.strip.empty? }
                item.xpath("ports/port").each { |c| obj.ports << c.text.strip if not c.text.strip.empty? }
            end
            # too specific move to vuln class end
            item.each do |attr, value|

                obj.send "#{attr}=", value
            end
            # vulnerability item
            itemlist << obj
        end
        return itemlist
    end
end