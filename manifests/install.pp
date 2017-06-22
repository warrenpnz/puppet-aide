# class for managing aide installation
class aide::install (
  $version,
  $package,
) {

  package { 'aide':
    ensure => $version,
    name   => $package,
  }

}
