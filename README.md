## Overview

This module manages FTP configuration at high level, it does not intend to be 
highly customizable.


## Module Description

The module allow local users to login and chroot them into their home 
directory.

Three parameters can be customized:

* FTP mode:
  * 'active'
  * 'passive'
* SSL encryption:
  * 'explicit'
  * 'implicit'
  * 'none'
* Anonymous enabled or not

Explicit SSL will encrypt both data and command on client demand while 
implicit SSL will start a SSL session right away. These modes are not 
compatible, and FTP client needs to be set accordingly.

## Examples

FTP server in passive mode with explicit encryption, anonymous not allowed. In 
this configuation, client connect to tcp port 21 and explicitly ask for TLS 
during the FTP session. Firewall need to be opened for incomming connection 
to range port tcp/2121-2131 and tcp/21.

```
class { 'ftpserver':
  ssl           => 'explicit',
  mode          => 'passive',
  pasv_min_port => '2121',
  pasv_max_port => '2131',
  allow_anon    => false
```

FTP server in passive mode, SSL set to implicit. Connection first establish a 
SSL handshake. FTP server listen on ftps tcp port (990). Firewall need to be 
opened for incomming connection to range port tcp/2121-2131 and tcp/990.

```
class { 'ftpserver':
  ssl           => 'implicit',
  mode          => 'passive',
  pasv_min_port => '2121',
  pasv_max_port => '2131',
```

FTP server in active mode, SSL disabled and anonymous user allowed:

```
class { 'ftpserver':
  ssl           => 'none',
  mode          => 'active',
  allow_anon    => true
}
```

## Limitations

* Work only on CentOS/RHEL distributions. Tested on RHEL 6 / 7 with Puppet 3.6
* Does not manage firewall rules
* Support only local user account

