# == Class: ftpserver
#
# Install and configure vsftpd and 
#
# === Parameters
#
# Document parameters here.
#
# [*conf_dir*]
#   Must be a valid absolute path.
#
# [*package_name*]
#   Package name.
#
# [*service_name*]
#   Service name.
#
# [*mode*]
#   FTP mode, either 'active' or 'passive'.
#
# [*pasv_port*]
#   Only needed if mode is set to 'passive'. Define the ports range used in
#   passive mode.
#
# [*ssl*]
#   Enable SSL. possible values are: 'implicit', 'explicit', 'none'
#
# [*cert_file*]
#   Only needed if ssl is activated. If the certificate file doesn't exist,
#   a dummy certificate will be created.
#
# [*allow_anon*]
#   Allow anonymous user to connect.
#
# === Examples
#
#  class { vsftpd:
#   mode          => 'passive',
#   pasv_min_port => '9991',
#   pasv_max_port => '9999',
#   $ssl          => 'explicit',
#   allow_anon    => false',
#  }
#
# === Authors
#
# Jeremy Bertozzi <jeremy.bertozzi@gmail.com>
#
# === Copyright
#
# Copyright 2016 Jeremy Bertozzi
#

class ftpserver (
  $conf_dir       = $::ftpserver::params::conf_dir,
  $package_name   = $::ftpserver::params::package_name,
  $service_name   = $::ftpserver::params::service_name,
  $mode           = $::ftpserver::params::mode,
  $pasv_min_port  = $::ftpserver::params::pasv_min_port,
  $pasv_max_port  = $::ftpserver::params::pasv_max_port,
  $ssl            = $::ftpserver::params::ssl,
  $cert_file      = $::ftpserver::params::cert_file,
  $allow_anon     = $::ftpserver::params::allow_anon,
) inherits ftpserver::params {

  package{$package_name:
    ensure  => "installed",
  }

  service{$service_name:
    ensure  => "running",
    enable  => "true",
    require => Package[$package_name],
  }

  file{"${conf_dir}/vsftpd.conf":
    content => template("${module_name}/vsftpd.conf.erb"),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

  if ($ssl != 'none'){
    exec {"Generate certificate: ${cert_file}":
      command => "/etc/pki/tls/certs/make-dummy-cert ${cert_file}",
      creates => "${cert_file}",
      notify  => Service[$service_name],
    }
  }

}
