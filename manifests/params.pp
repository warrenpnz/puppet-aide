# aide::params sets the default values for parameters.
class aide::params {
  $package              = 'aide'
  $mailto               = undef
  $mail_only_on_changes = false
  $version              = 'latest'
  $db_path              = '/var/lib/aide/aide.db'
  $db_temp_path         = '/var/lib/aide/aide.db.new'
  $gzip_dbout           = 'no'
  $hour                 = 0
  $minute               = 0
  $aide_log             = '/var/log/aide/aide.log'
  $syslogout            = true
  $config_template      = 'aide/aide.conf.erb'
  $cron_template        = 'aide/cron.erb'
  $nocheck              = false

  case $::osfamily {
    'Debian': {
      $aide_path = '/usr/bin/aide'
      $cat_path  = '/bin/cat'
      $rm_path   = '/bin/rm'
      $conf_path = '/etc/aide/aide.conf'
    }
    'Redhat': {
      $aide_path = '/usr/sbin/aide'
      $cat_path  = '/usr/bin/cat'
      $rm_path   = '/usr/bin/rm'
      $conf_path = '/etc/aide.conf'
    }
    default: {
      $aide_path = '/usr/sbin/aide'
      $cat_path  = '/usr/bin/cat'
      $rm_path   = '/usr/bin/rm'
      $conf_path = '/etc/aide.conf'
      #fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
