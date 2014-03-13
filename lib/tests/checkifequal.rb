require "test/unit"
require 'nokogiri'
require_relative "../../system.rb"
#http://ruby-doc.org/stdlib-2.0.0/libdoc/test/unit/rdoc/Test/Unit/Assertions.html

class TestXMLIsEqual < Test::Unit::TestCase

	def setup
	  @vulns = []

	  @systems = []
	  doc = Nokogiri::XML(File.read(BOXES_DIR))
	  doc.xpath("//systems/system").each do |system|
	    id = system["id"]
	    os = system["os"]
	    base = system["basebox"]
	    vulns = system.css('vulnerabilities vulnerability').collect do |v| 
	    	vuln = Vulnerability.new
	    	vuln.type = v[:type]
	    	vuln.privilege = v[:privilege]
	    	vuln.access = v[:access]
	    	vuln.puppet = v[:puppet]
	    	vuln.details = v[:details]
	    	return vuln
	      end
	    networks = system.css('networks network').collect { |n| n['name'] }
	 	
	    @systems << System.new(id, os, base, vulns, networks)
	    return @systems
	  end
	end

	def test_system_data
		
		# check systems are correct
		assert_equal(@systems[0].id, "system1")
		assert_equal(@systems[1].id, "system2")
		assert_equal(@systems[2].id, "system3")

		# test to see if xml data is being retrieved correctly 
		dummy_vulnerability = Vulnerability.new
		dummy_vulnerability.type = "nfs"
		dummy_vulnerability.puppet = ""
		dummy_vulnerability.details = ""
		@systems.each do |s|
		  # check if list of vulnerabilities
		  assert_equal(s.vulns.kind_of?(Array), true)
		  s.vulns.each do |v|
		  	if v.type == dummy_vulnerability.type
		  	  assert_equal(v.type, "nfs")
		  	end
		  end
		end
	end

	def test_system
	  dummy_list = []
	  dummy_data = Vulnerability.new
	  dummy_data.type = "ftp"
	  dummy_data.privilege = "user"
	  dummy_data.access = "remote"
	  dummy_data.puppet = ""
	  dummy_data.details = ""
	  dummy_list << dummy_data
	  dummy_data1 = Vulnerability.new
	  dummy_data1.type = "fakedata"
	  dummy_data1.privilege = "fakedata"
	  dummy_data1.access = "fakedata"
	  dummy_data1.puppet = ""
	  dummy_data1.details = ""
	  dummy_list << dummy_data1
	  known_vulns = []

	  s = System.new("system1", "linux", "base", dummy_list, [])
	  known_vulns = s.list_vulns_from_system
	  assert_equal(known_vulns.length,1)
	  assert_equal(known_vulns[0].type,"ftp") 
	end
end