def vagrant_up(build_number)
	p 'building now.....'
	command = "cd #{PROJECTS_DIR}/Project#{build_number}/; vagrant up"
	exec command 
end