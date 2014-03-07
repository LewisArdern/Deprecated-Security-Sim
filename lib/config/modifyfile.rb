require 'tempfile'
require 'fileutils'

path = '/Users/lewisardern/Documents/Security-Simulator/projects/'
temp_file = Tempfile.new('foo')
begin
  File.open(path, 'r') do |file|
    file.each_line do |line|
      puts line
    end
  end
ensure

end