node default {
  # This will install aide and do initial db creation but disable the cron job
  class { 'aide':
    nocheck => true,
  }
  aide::rule { 'MyRule':
    rules => [ 'p', ],
  }
  aide::watch { '/etc':
    path  => '/etc',
    rules => 'MyRule'
  }

}
