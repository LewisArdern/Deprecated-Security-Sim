class vsftpd::config {

  service { 'vsftpd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  file { '/etc/vsftpd.conf':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('vsftpd/vsftpd.conf.erb'),
    notify  => Service['vsftpd'],
  }

  if $vsftpd::enable_ssl {
    file { '/etc/ssl/private/vsftpd.pem':
      ensure => present,
      mode   => '0644',
      owner  => 'root',
      group  => 'root',
      source => $vsftpd::ssl_pem_key,
      notify => Service['vsftpd'],
    }
  }
}
