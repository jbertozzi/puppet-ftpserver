class {'ftpserver':
  mode          => 'passive',
  ssl           => 'explicit',
  pasv_min_port => '2121',
  pasv_max_port => '2131',
  allow_anon    => false,
}
