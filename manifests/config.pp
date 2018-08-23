# class managing aide configuration.
class aide::config (
  $conf_path,
  $db_dir,
  $log_dir,
  $db_filename,
  $db_temp_filename,
  $aide_log_file,
  $gzip_dbout,
  $syslogout,
  $config_template,
) {

  concat { 'aide.conf':
    path  => $conf_path,
    owner => 'root',
    group => 'root',
    mode  => '0600',
  }

  concat::fragment { 'aide.conf.header':
    target  => 'aide.conf',
    order   => 01,
    content => template( $config_template ),
  }

  concat::fragment { 'rule_header':
    target  => 'aide.conf',
    order   => '02',
    content => "# User defined rules\n",
  }

  concat::fragment { 'watch_header':
    target  => 'aide.conf',
    order   => '45',
    content => "\n# Files and directories to scan\n",
  }

}
