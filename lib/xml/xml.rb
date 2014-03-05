require 'nokogiri'

 

doc = Nokogiri::XML(File.open("boxesconfig.xml"))


doc.search('//systems/system').each do |system|
    systemNumber  = system.at('@number').text
    os  = system.at('//os/@system').text
    base = system.at('//os/@basebox').text
   
    #vulnerabilities << { "critical" => system.at('//vulnerability/@critical').text, "access" => system.at('//vulnerability/@access').text}
  	  vulnerabilities = system.css('vulnerabilities vulnerability').collect do |vulnerability| 
 	  { 'critical' => vulnerability['critical'], 'access' => vulnerability['access'] } 
	end
	  	  networks = system.css('networks network').collect do |network| 
 	  { 'network' => network['name'] } 
	end

    puts vulnerabilities
    puts systemNumber
    puts os
    puts networks    
end

