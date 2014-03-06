# == Class: vsftpd
#
# Installs and manages vsftpd.
#
# === Parameters
#
# [*anonymous_enable*]
#  Allow anonymous FTP. Default: false
#
# [*local_enable*]
#  Allow local users to log in. Default: false
#
# [*write_enable*]
#  Enable any form of FTP write command. Default: false
#
# [*chroot_local_user*]
#  Restrict local users to their home directories. Default: true
#
# [*idle_session_timeout*]
#  Set the Idle Session Timeout for the server in seconds. Default: 120
#
# [*ftpd_banner*]
#  Set a welcome message to those users that connect to the server. Default: ""
#
# [*enable_ssl*]
#  Turn on SSL only communications with the FTP Server. Requires that the ssl_pem_key setting be set as well. Default: false
#
# [*ssl_pem_key*]
#  Use the file specified as the PEM Public/Private key pair for SSL support in the FTP server. Default: ""
#
# === Examples
#
# class { 'vsftpd':
#   anonymous_enable     => false,
#   local_enable         => true,
#   write_enable         => true,
#   chroot_local_user    => true,
#   idle_session_timeout => 600,
#   ftpd_banner          => 'My FTP server',
#   enable_ssl           => true,
#   ssl_pem_key          => 'puppet:///modules/client_applications/myftpserver.pem'
# }
#
# === Authors
#
# Sergey Stankevich, Eric Hankinson
#
class vsftpd (
  $anonymous_enable  = false,
  $local_enable      = false,
  $write_enable      = false,
  $chroot_local_user = true,
  $idle_session_timeout = 120,
  $ftpd_banner = '',
  $enable_ssl = false,
  $ssl_pem_key = '',
) {

  # Compatibility check
  $compatible = [ 'Debian', 'Ubuntu', 'CentOS']
  if ! ($::operatingsystem in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  Class['vsftpd::install'] -> Class['vsftpd::config']

  include vsftpd::install
  include vsftpd::config

}
