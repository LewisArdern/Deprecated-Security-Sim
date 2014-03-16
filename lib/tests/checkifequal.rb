require "test/unit"
require 'nokogiri'
require_relative "../../system.rb"
require_relative "../../random.rb"
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
	    	Vulnerability.new(v[:type],v[:privilege],v[:access],v[:puppet],v[:details])
	      end
	    networks = system.css('networks network').collect { |n| n['name'] }

	    @systems << System.new(id, os, base, vulns, networks)
	  end
	end

	def test_system_data
		# check systems are correct
		assert_equal(@systems[0].id, "system1")
		assert_equal(@systems[1].id, "system2")
		assert_equal(@systems[2].id, "system3")
	end

	# def test_system
	#   dummy_list = []
	#   dummy_data = Vulnerability.new("ftp","user", "remote","", "")

	#   dummy_list << dummy_data
	#   dummy_data1 = Vulnerability.new("THISISFAKE","root", "remote","", "")

	#   dummy_list << dummy_data1
	#   known_vulns = []

	#   s = System.new("system1", "linux", "base", dummy_list, [])
	#   known_vulns = s.	
	#   assert_equal(known_vulns.length,1)
	#   assert_equal(known_vulns[0].type,"ftp")
	# end

	def test_intersection
		list1 = [Vulnerability.new("nfs","root", "remote","", ""), Vulnerability.new("ftp","root", "remote","", "")]
		list2 = [Vulnerability.new("nfs","root", "remote","", ""), Vulnerability.new("samba","root", "remote","", ""), ]
		p ilist = list1 & list2

	end

	def test_system_vulnerabilities
		dummy_list = []

	  	empty_type = Vulnerability.new("","root", "remote","", "")

        valid_type = Vulnerability.new("ftp","root", "remote","", "")

        invalid_type = Vulnerability.new("THISISFAKE","root", "remote","", "")

	    valid_type = Vulnerability.new("nfs","root", "remote","", "")
	    valid_type1 = Vulnerability.new("nfs","root", "remote","", "")

	    
	    if empty_type.type == ""
	    	p empty_type
	    	vuln = generate_vulnerability(empty_type,Conf.vulnerabilities,dummy_list)
	    	assert_not_match(vuln,"")
	    end
	
	 		 # valid = generate_vulnerability(valid_type,Conf.vulnerabilities,dummy_list)
	 		 # invalid = generate_vulnerability(invalid_type,Conf.vulnerabilities,dummy_list)
	 		 # duplicate = generate_vulnerability(valid_type,Conf.vulnerabilities,dummy_list)
		# 2. Run checks against dummy list to compare
		# 		a. Randomly choose a vulnerability of any type. Check for duplicates.
		# 		b. valid type: add to list (if no duplicates)
		#       c. Invalid type: throws an error; fails gracefully
		#       d. Valid (but duplicate) type: throws an error; fails gracefully
	end

	def test_system_networks
		#
	end
end