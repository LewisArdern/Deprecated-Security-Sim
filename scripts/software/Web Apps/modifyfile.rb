path = '~/Documents/Security\ Simulator/config/dvwa.config'
temp_file = Tempfile.new('foo')
begin
  File.open(path, 'r') do |file|
    file.each_line do |line|
    	next if line.match(/$_DVWA[ 'db_password' ] =/)
    	{
    		line = "$_DVWA[ 'db_password' ] = 'PasswordFromConfigurationFile';"
    	}
    	puts line
      temp_file.puts line
    end
  end
  temp_file.rewind
  FileUtils.mv(temp_file.path, path)
ensure
  temp_file.close
  temp_file.unlink
end