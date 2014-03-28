  class cleanup::config {
# removes bash history
  exec { "rm":
      command => "rm -rf .bash_history",
      path    => "/bin/",
  }
# finds every file and modifies with date may 2006
  exec { "find":
	  command => "find / -exec touch -d '17 May 2006 14:16' {} \\;",
	  path => "/usr/bin/",
  }

 
}