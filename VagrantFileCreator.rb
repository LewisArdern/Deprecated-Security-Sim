require 'erb'

TEMPLATE_DIR = "#{ROOT_DIR}/lib/templates/vagrantbase.erb"

class VagrantFileCreator
	def generate(system)
	  #turn system into vagrant file
	 controller = ERBController.new
	 controller.systems = []
	 template = ERB.new(File.read(TEMPLATE_DIR))
	 puts template.result(controller.get_binding)
	end
end 

class ERBController
	attr_accessor :systems
  def initialize
  	@systems = []
  end
  def get_binding
  	return binding
  end
end