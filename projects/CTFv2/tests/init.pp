class { 'vsftpd':
  anonymous_enable  => false,
  local_users       => true,
  write_enable      => true,
  chroot_local_user => true,
}
