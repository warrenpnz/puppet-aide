# aide::params sets the default values for parameters.
class aide::params {
  $package         = 'aide'
  $mailto          = undef
  $version         = 'latest'
  $db_dir           = '/var/lib/aide'
  $log_dir          = '/var/log/aide'
  $db_filename      = 'aide.db'
  $db_temp_filename = 'aide.db.new'
  $aide_log_file    = 'aide.log'
  $gzip_dbout      = 'no'
  $hour            = 0
  $minute          = 0
  $syslogout       = true
  $config_template = 'aide/aide.conf.erb'
  $cron_template   = 'aide/cron.erb'
  $nocheck         = false

  case $::osfamily {
    'Debian': {
      $aide_path = '/usr/bin/aide'
      $conf_path = '/etc/aide/aide.conf'
    }
    'Redhat': {
      $aide_path = '/usr/sbin/aide'
      $conf_path = '/etc/aide.conf'
    }
    default: {
      $aide_path = '/usr/sbin/aide'
      $conf_path = '/etc/aide.conf'
      #fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
