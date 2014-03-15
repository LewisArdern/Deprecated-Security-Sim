def generate_base(system,bases)
	box = bases.sample
	p system.basebox
	system.basebox = box.vagrantbase 
	return system
end

def generate_vulnerability(system,vulns,list)
	vuln = vulns.sample 
	list.each do |l|
		if vulns.type == l.type
			return nil
		else
		system.type = vuln.type
		end
	end
	return system
end
