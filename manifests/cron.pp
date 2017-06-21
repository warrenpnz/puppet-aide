# Class for managing aide's cron job.
class aide::cron (
  $aide_path,
  $db_path,
  $minute,
  $hour,
  $mailto,
  $cron_template,
) {

  file { '/etc/cron.d/aide':
    ensure  => present,
    content => template( $cron_template ),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['aide'],
  }

}
