node default {
  include 'aide'

  aide::rule {
    'MD5':       rules => [ 'p', 'i', 'u', 'g', 'md5' ] ;
    'PermsOnly': rules => [ 'p', 'u', 'g', 'acl', 'selinux', 'xattrs' ] ;
  }

  aide::watch { 
    '/etc':                             rules => [ 'MD5' ] ;
    '/bin':                             rules => [ 'R' ] ;
    '/sbin':                            rules => [ 'R' ] ;
    '/usr':                             rules => [ 'R' ] ;
    '/var/lib/aide/.*':                 rules => [ 'L' ] ;
    '/var':                             rules => [ 'PermsOnly' ] ;
    '/swapfile.*':                      type => 'exclude' ;
    '/var/log/.*':                      type => 'exclude' ;
    '/var/cache/.*':                    type => 'exclude' ;
    '/var/spool/.*':                    type => 'exclude' ;
  }

}

