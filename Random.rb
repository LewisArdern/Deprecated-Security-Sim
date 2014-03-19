
def generate_base(system,bases)
	box = bases.sample
	# p system.basebox
	system.basebox = box.vagrantbase 
	system.url = box.url
	return system
end

def generate_vulnerability(system,vulns)
	
 	# vuln = vulns.sample
		# if system.type == ""		 
		# 	system.type = vuln.type
		# 	return system
		# end
	# vulns.each do |v|
	#     if system.type == ""
	#        system.type = vuln.type
	#     # elsif system.type == $valid_type
	#     #     get a random vulnerability of type $valid_type
	#     # elsif system.type == $invalid_type
	#     #     # nothing
	# 	end
	# end
end

# def check_list(vulns,list)
# 	vuln = vulns.sample 
# 	if system.type == ""
# 		checkif
# 	end

# 	end
# end
