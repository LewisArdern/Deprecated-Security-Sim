require 'erb'
require_relative 'system.rb'

TEMPLATE_DIR = "#{ROOT_DIR}/lib/templates/vagrantbase.erb"


class VagrantFileCreator

  def initialize(systems)
    @systems = systems
  end
	def generate(system)
	  #turn system into vagrant file
	 controller = ERBController.new
	 controller.systems = system
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


# class VagrantFile
	
# 	def initialize(systems)
# 		@systems = systems
# 	end 

# 	def save_to_file(file)
# 		File.open(file, "w+") do |f|
#     	f.write(render)
# 	end

# 	def render
# 	end

# end
# 	# config.vm.network "private_network", ip: "192.168.50.4"

# 	# config.vm.box = "base"

# end