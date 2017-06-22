# class for managing aide installation
class aide::install (
  $version,
  $package,
) {

  package { $package:
    ensure => $version,
  }

}
