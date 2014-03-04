require 'nokogiri'

doc = Nokogiri::XML(File.open("boxesconfig.xml"))
@block = doc.css("Systems").map {|node| node.children.text}
puts @block