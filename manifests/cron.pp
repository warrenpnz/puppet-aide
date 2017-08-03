# Class for managing aide's cron job.
class aide::cron (
  $aide_path,
  $minute,
  $hour,
  $nocheck,
) {

  if $nocheck == true {
    $cron_ensure = 'absent'
  } else {
    $cron_ensure = 'present'
  }

  cron { 'aide':
    ensure  => $cron_ensure,
    command => "${aide_path} --check",
    user    => 'root',
    hour    => $hour,
    minute  => $minute,
  }

}
