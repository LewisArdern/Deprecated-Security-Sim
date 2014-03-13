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


class VagrantFile
	attr_accessor :bases, :networks, :vulns, :systems

	def initialize(systems)
		@systems = systems
	end 

	def save_to_file

	end

	def render

end
	# config.vm.network "private_network", ip: "192.168.50.4"

	# config.vm.box = "base"


end