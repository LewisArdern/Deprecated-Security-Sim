require 'nokogiri'
require 'tempfile'
require 'fileutils'


# class Vulnerability
# 	@os = "test"
# 	@base = "test"
# 	def setOs(newos)
# 		@os = newos
# 	end
# 	def getOs()
# 		return @os
# 	end
# 	def 

# end

class System
	@os
	@base
	@number
	@vulnerabilities
	#@vulnerabity = Vulnerability.new
	def setOs(newos)
		@os = newos
	end
	def getOs()
		return @os
	end
	def setBase(newbase)
		@base = newbase
	end
	def getBase()
		return @base
	end
	def setSystemNumber(newnumber)
		@number = newnumber
	end
	def getSystemNumber()
		return @number
	end
end



 
def readXMLSystems

	doc = Nokogiri::XML(File.open("/Users/lewisardern/Documents/Security-Simulator/lib/xml/boxesconfig.xml"))
	# puts doc
	systeminstance = ""
	systemArray = []
	
	doc.search('//systems/system').each do |system|
		systeminstance = System. new 
	    number = system.at('@number').text
	    systeminstance.setSystemNumber number
	    os = system.at('@os').text
	    systeminstance.setOs os
	    base = system.at('@basebox').text
	    systeminstance.setBase base
	   
	  	vulnerabilities = system.css('vulnerabilities vulnerability').collect do |vulnerability| 
	 		{ 'critical' => vulnerability['critical'], 'access' => vulnerability['access'] } 
		end
		networks = system.css('networks network').collect do |network| 
	 		{ 'network' => network['name'] } 
		end
		systemArray.push(systeminstance)
	end
	
	return systemArray
end


# def createVagrantFile
# out_file = File.new("/Users/lewisardern/Documents/Security-Simulator/projects/CTFv2/VagrantFile", "w")

# doc = Nokogiri::XML(File.open("/Users/lewisardern/Documents/Security-Simulator/lib/xml/boxesconfig.xml"))


# doc.search('//systems/system').each do |system|
# 	out_file.puts(system)
#     systemNumber  = system.at('@number').text
#     os  = system.at('//os/@system').text
#     base = system.at('//os/@basebox').text
   
#   	  vulnerabilities = system.css('vulnerabilities vulnerability').collect do |vulnerability| 
#  	  { 'critical' => vulnerability['critical'], 'access' => vulnerability['access'] } 
# 	end
# 	  	  networks = system.css('networks network').collect do |network| 
#  	  { 'network' => network['name'] } 
# 	end
	  
# end
# out_file.close
# end

