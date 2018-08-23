# the aide class manages some the configuration of aide
class aide (
  $package         = $aide::params::package,
  $version         = $aide::params::version,
  $conf_path       = $aide::params::conf_path,
  $db_dir           = $aide::params::db_dir,
  $log_dir          = $aide::params::log_dir,
  $db_filename      = $aide::params::db_filename,
  $db_temp_filename = $aide::params::db_temp_filename,
  $aide_log_file    = $aide::params::aide_log_file,
  $db_path          = "${db_dir}/${db_filename}",
  $db_temp_path     = "${db_dir}/${db_temp_filename}",
  $hour            = $aide::params::hour,
  $minute          = $aide::params::minute,
  $gzip_dbout      = $aide::params::gzip_dbout,
  $aide_path       = $aide::params::aide_path,
  $aide_log         = "${log_dir}/${aide_log_file}",
  $syslogout       = $aide::params::syslogout,
  $config_template = $aide::params::config_template,
  $nocheck         = $aide::params::nocheck,
  $mailto          = $aide::params::mailto,
) inherits aide::params {

  package { $package:
    ensure => $version,
  }

  -> class  { '::aide::cron':
      aide_path => $aide_path,
      minute    => $minute,
      hour      => $hour,
      nocheck   => $nocheck,
      require   => Package[$package],
    }

  -> class  { '::aide::config':
      conf_path        => $conf_path,
      db_dir           => $db_dir,
      log_dir          => $log_dir,
      db_filename      => $db_filename,
      db_temp_filename => $db_temp_filename,
      aide_log_file    => $aide_log_file,
      verbose          => $verbose,
      gzip_dbout       => $gzip_dbout,
      syslogout        => $syslogout,
      config_template  => $config_template,
      require          => Package[$package],
    }

  ~> class  { '::aide::firstrun':
      aide_path    => $aide_path,
      conf_path    => $conf_path,
      db_temp_path => $db_temp_path,
      db_path      => $db_path,
      require      => Package[$package],
    }

}
