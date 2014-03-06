[puppet-vsftpd](https://github.com/stankevich/puppet-vsftpd)
======

Puppet module for installing and managing vsftpd.

## Usage

### vsftpd

Installs and manages vsftpd.

**anonymous_enable** — Allow anonymous FTP. Default: false

**local_enable** — Allow local users to log in. Default: false

**write_enable** — Enable any form of FTP write command. Default: false

**chroot_local_user** — Restrict local users to their home directories. Default: true

**idle_session_timeout** — Set the Idle Session Timeout for the server in seconds. Default: 120

**ftpd_banner** — Set a welcome message to those users that connect to the server. Default: ""

**enable_ssl** — Turn on SSL only communications with the FTP Server. Requires that the ssl_pem_key setting be set as well. Default: false

**ssl_pem_key** — Use the file specified as the PEM Public/Private key pair for SSL support in the FTP server. Default: ""

	class { 'vsftpd':
	  anonymous_enable     => false,
	  local_enable         => true,
	  write_enable         => true,
	  chroot_local_user    => true,
	  idle_session_timeout => 600,
	  ftpd_banner          => 'My FTP server',
	  enable_ssl           => true,
	  ssl_pem_key          => 'puppet:///files/myserver/myftpserver.pem'
	}

## Authors

[Sergey Stankevich](https://github.com/stankevich)
