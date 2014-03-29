require 'erb'
require_relative 'system.rb'


VAGRANT_TEMPLATE_FILE = "#{ROOT_DIR}/lib/templates/vagrantbase.erb"
REPORT_TEMPLATE_FILE = "#{ROOT_DIR}/lib/templates/report.erb"

PROJECTS_DIR = "#{ROOT_DIR}/projects"

class FileCreator
# Creates project directory, uses .erb files to create a report and the vagrant file that will be used
# to create the virtual machines
	def initialize(systems)
		@systems = systems
	end
	def generate(system)
		Dir::mkdir("#{PROJECTS_DIR}") unless File.exists?("#{PROJECTS_DIR}") 

		count = Dir["#{PROJECTS_DIR}/*"].length
		build_number = count.next

		p "the system is now creating the Project#{build_number}"
		Dir::mkdir("#{PROJECTS_DIR}/Project#{build_number}") unless File.exists?("#{PROJECTS_DIR}/#{build_number}") 

		controller = ERBController.new
		controller.systems = system
		vagrant_template = ERB.new(File.read(VAGRANT_TEMPLATE_FILE))
		p "#{PROJECTS_DIR}/Project#{build_number}/VagrantFile file has been created"
		File.open("#{PROJECTS_DIR}/Project#{build_number}/VagrantFile", 'w') { |file| file.write(vagrant_template.result(controller.get_binding)) }
		

		report_template = ERB.new(File.read(REPORT_TEMPLATE_FILE))
		p "#{PROJECTS_DIR}/Project#{build_number}/Report file has been created"
		File.open("#{PROJECTS_DIR}/Project#{build_number}/Report", 'w'){ |file| file.write(report_template.result(controller.get_binding)) }

		return build_number
	end

end 


class ERBController

# ERB Controller initializes the system and returns the binding when mapping .erb files
	attr_accessor :systems
	def initialize
		@systems = []
	end
	def get_binding
		return binding
	end
end