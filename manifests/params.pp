class ftpserver::params {

  $package_name   = 'vsftpd'
  $service_name   = 'vsftpd'
  $conf_dir       = '/etc/vsftpd'
  $mode           = 'passive'
  $pasv_min_port  = '2121'
  $pasv_max_port  = '2131'
  $ssl            = 'explicit'
  $cert_file      = "/etc/pki/tls/certs/${::fqdn}.pem"
  $allow_anon     = false

}
