require 'erb'
require_relative 'system.rb'

TEMPLATE_DIR = "#{ROOT_DIR}/lib/templates/vagrantbase.erb"
PROJECTS_DIR = "#{ROOT_DIR}/projects"


class VagrantFileCreator

	def initialize(systems)
		@systems = systems
	end
	def generate(system)
		controller = ERBController.new
		controller.systems = system
		template = ERB.new(File.read(TEMPLATE_DIR))
		count = Dir["#{PROJECTS_DIR}/*"].length
		build_number = count.next
		Dir::mkdir("#{PROJECTS_DIR}/Project#{build_number}") unless File.exists?("#{PROJECTS_DIR}/#{build_number}")
		File.open("#{PROJECTS_DIR}/Project#{build_number}/VagrantFile", 'w') { |file| file.write(template.result(controller.get_binding)) }
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