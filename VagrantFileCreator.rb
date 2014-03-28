require 'erb'
require_relative 'system.rb'
require_relative 'vagrant.rb'


VAGRANT_TEMPLATE_FILE = "#{ROOT_DIR}/lib/templates/vagrantbase.erb"
REPORT_TEMPLATE_FILE = "#{ROOT_DIR}/lib/templates/report.erb"

PROJECTS_DIR = "#{ROOT_DIR}/projects"


class VagrantFileCreator

	def initialize(systems)
		@systems = systems
	end
	def generate(system)
		paths = []
		count = Dir["#{PROJECTS_DIR}/*"].length
		build_number = count.next
		Dir::mkdir("#{PROJECTS_DIR}/Project#{build_number}") unless File.exists?("#{PROJECTS_DIR}/#{build_number}")

		controller = ERBController.new
		controller.systems = system
		controller.manifest_paths = paths
		vagrant_template = ERB.new(File.read(VAGRANT_TEMPLATE_FILE))
		File.open("#{PROJECTS_DIR}/Project#{build_number}/VagrantFile", 'w') { |file| file.write(vagrant_template.result(controller.get_binding)) }
		

		report_template = ERB.new(File.read(REPORT_TEMPLATE_FILE))
		File.open("#{PROJECTS_DIR}/Project#{build_number}/Report", 'w'){ |file| file.write(report_template.result(controller.get_binding)) }
		vagrant_up(build_number)
	end
end 


class ERBController
	attr_accessor :systems, :manifest_paths
	def initialize
		@systems = []
		@manifest_paths = []
	end
	def get_binding
		return binding
	end
end