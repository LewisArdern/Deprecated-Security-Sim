require 'erb'
require_relative 'system.rb'
require_relative 'vagrant.rb'
require_relative 'report.rb'

VAGRANT_TEMPLATE_FILE = "#{ROOT_DIR}/lib/templates/vagrantbase.erb"
REPORT_TEMPLATE_FILE = "#{ROOT_DIR}/lib/templates/report.erb"

PROJECTS_DIR = "#{ROOT_DIR}/projects"


class VagrantFileCreator

	def initialize(systems)
		@systems = systems
	end
	def generate(system)
		# vagrant_controller = ERBController.new
		# vagrant_controller.systems = system
		# vagrant_template = ERB.new(File.read(VAGRANT_TEMPLATE_FILE))
		count = Dir["#{PROJECTS_DIR}/*"].length
		build_number = count.next
		Dir::mkdir("#{PROJECTS_DIR}/Project#{build_number}") unless File.exists?("#{PROJECTS_DIR}/#{build_number}")
		# File.open("#{PROJECTS_DIR}/Project#{build_number}/VagrantFile", 'w') { |file| file.write(vagrant_template.result(vagrant_controller.get_binding)) }

		report_controller = ERBController.new
		report_controller.systems = system
		report_template = ERB.new(File.read(REPORT_TEMPLATE_FILE))
		File.open("#{PROJECTS_DIR}/Project#{build_number}/Report", 'w') { |file| file.write(report_template.result(report_controller.get_binding)) }
		# vagrant_up(build_number)

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