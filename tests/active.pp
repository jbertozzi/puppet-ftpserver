class {'ftpserver':
  mode          => 'active',
  ssl           => 'implicit',
  allow_anon    => true
}

