# the aide::firstrun class creates the database that will be used for future checks.
class aide::firstrun (
  $aide_path,
  $conf_path,
  $db_temp_path,
  $db_path,
) {

  exec { 'aide init':
    command     => "${aide_path} --init --config ${conf_path}",
    user        => 'root',
    refreshonly => true,
    subscribe   => Concat['aide.conf'],
  }

  exec { 'install aide db':
    command     => "/bin/cp -f ${db_temp_path} ${db_path}",
    user        => 'root',
    refreshonly => true,
    subscribe   => Exec['aide init'],
  }

  file { $db_path:
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0600',
    require => Exec['install aide db'],
  }

  file { $db_temp_path:
    owner   => root,
    group   => root,
    mode    => '0600',
    require => Exec['aide init'],
  }

}
