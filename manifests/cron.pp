# Class for managing aide's cron job.
class aide::cron (
  $aide_path,
  $cat_path,
  $rm_path,
  $conf_path,
  $minute,
  $hour,
  $nocheck,
  $mailto,
  $mail_only_on_changes,
) {

  if $nocheck == true {
    $cron_ensure = 'absent'
  } else {
    $cron_ensure = 'present'
  }

  if $mailto != undef {
    if $mail_only_on_changes {
      cron { 'aide':
        ensure  => $cron_ensure,
        command => "LOG=$(mktemp) && ${aide_path} --config ${conf_path} --check > \$LOG 2>&1 || ${cat_path} -v \$LOG | /usr/bin/mail -E -s \"\$(hostname) - AIDE Integrity Check\" ${mailto}; ${rm_path} -f \$LOG",
        user    => 'root',
        hour    => $hour,
        minute  => $minute,
      }
    } else {
      cron { 'aide':
        ensure  => $cron_ensure,
        command => "${aide_path} --config ${conf_path} --check | /usr/bin/mail -s \"\$(hostname) - AIDE Integrity Check\" ${mailto}",
        user    => 'root',
        hour    => $hour,
        minute  => $minute,
      }
    }
  } else {
    cron { 'aide':
      ensure  => $cron_ensure,
      command => "${aide_path} --config ${conf_path} --check",
      user    => 'root',
      hour    => $hour,
      minute  => $minute,
    }
  }
}
