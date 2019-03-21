# the aide class manages some the configuration of aide
class aide (
  $package              = $aide::params::package,
  $version              = $aide::params::version,
  $conf_path            = $aide::params::conf_path,
  $db_path              = $aide::params::db_path,
  $db_temp_path         = $aide::params::db_temp_path,
  $hour                 = $aide::params::hour,
  $minute               = $aide::params::minute,
  $gzip_dbout           = $aide::params::gzip_dbout,
  $aide_path            = $aide::params::aide_path,
  $aide_log             = $aide::params::aide_log,
  $syslogout            = $aide::params::syslogout,
  $config_template      = $aide::params::config_template,
  $nocheck              = $aide::params::nocheck,
  $mailto               = $aide::params::mailto,
  $mail_only_on_changes = $aide::params::mail_only_on_changes,
) inherits aide::params {

  package { $package:
    ensure => $version,
  }

  -> class  { '::aide::cron':
      aide_path            => $aide_path,
      cat_path             => $aide::params::cat_path,
      rm_path              => $aide::params::rm_path,
      minute               => $minute,
      hour                 => $hour,
      nocheck              => $nocheck,
      mailto               => $mailto,
      mail_only_on_changes => $mailto,
      conf_path            => $conf_path,
      require              => Package[$package],
    }

  -> class  { '::aide::config':
      conf_path       => $conf_path,
      db_path         => $db_path,
      db_temp_path    => $db_temp_path,
      gzip_dbout      => $gzip_dbout,
      aide_log        => $aide_log,
      syslogout       => $syslogout,
      config_template => $config_template,
      require         => Package[$package],
    }

  ~> class  { '::aide::firstrun':
      aide_path    => $aide_path,
      conf_path    => $conf_path,
      db_temp_path => $db_temp_path,
      db_path      => $db_path,
      require      => Package[$package],
    }

}
