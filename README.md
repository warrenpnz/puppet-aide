# AIDE - Advanced Intrusion Detection Enviroment.

#### Table of Contents

1. [Description](#description)
2. [Examples](#examples)
3. [Cron Entry](#cron)
4. [Reference - What the module is doing and how](#reference)
5. [Assigning parameters using Hiera](#hiera)
6. [Limitations](#limitations)
7. [Contributing to the development of this module](#contributing)
8. [Credits](#Credits)

## Description

This is a module for managing the installation, configuration and initial database creation of the [AIDE](http://aide.sourceforge.net/) (Advanced Intrustion Detection Environment) package.

AIDE creates a database of files and their attributes from the rules that it finds in its config file. Once this database is initialized, it can be used to verify the integrity of the files contained within it. If the file attributes change according to the rules supplied, a summary of changes is logged and can be acted upon.

Refer to the [AIDE manual](http://aide.sourceforge.net/stable/manual.html) for further details about configuration options.

The module will also add a cron job to periodically run the `aide --check` command to verify the integrity of the AIDE database. Results will be logged to the log file (defaults to `/var/log/aide/aide.log`) and to the AUTH log facility.

## Examples

==========

Include the aide class and set cron run time to 6am with mail to a user other than root
----------
  class { 'aide':
    mailto => 'foo@bar.com',
    minute => 0,
    hour   => 6,
  }

Watch permissions of all files on filesystem
----------

The simplest use of `warrenpnz/aide` is to place a watch on the root directory, as follows.

    aide::watch { 'example':
      path  => '/',
      rules => 'p'
    }

This example adds the line `/ R` which watches the permissions of all files on the operating system.  Obviously, this is a simplistic, non useful solution.

Watch permissions and md5sums of all files in /etc
----------

    aide::watch { 'example':
      path  => '/etc',
      rules => 'p+md5'
    }

This example adds the line `/etc p+md5` which watches `/etc` with both permissions and md5sums.  This could also be implemented as follows.

    aide::watch { 'example':
      path  => '/etc',
      rules => ['p', 'md5']
    }


Create a common rule for watching multiple directories
-----------

Sometimes you wish to use the same rule to watch multiple directories, and in keeping with the Don't Repeat Yourself(DRY) viewpoint, we should create a common name for the rule.  This can be done via the `aide::rule` stanza.

    aide::rule { 'MyRule':
      name  => 'MyRule',
      rules => ['p', 'md5']
    }
    aide::watch { '/etc':
      path  => '/etc',
      rules => 'MyRule'
    }
    aide::watch { 'otherApp':
      path  => '/path/to/other/config/dir',
      rules => 'MyRule'
    }

Here we are defining a rule in called **MyRule** which will add the line `MyRule = p+md5`.  The next two stanzas can reference that rule.  They will show up as `/etc MyRule` and `/path/to/other/config/dir MyRule`.

Create a rule to exclude directories
-----------

    aide::watch { '/var/log':
      path => '/etc',
      type => 'exclude'
    }

This with ignore all files under /var/log.  It adds the line `!/var/log` to the config file.

Create a rule to watch only specific files
-----------

    aide::watch { '/var/log/messages':
      path => '/etc',
      type => 'equals',
      rules => 'MyRule'
    }

This will watch only the file /var/log/messages.  It will ignore /var/log/messages/thingie.  It adds the line `=/var/log/messages MyRule` to the config file.

## Cron

A cron file is created at /etc/cron.d/aide during installation to run aide checks that use the `hour` and `minute` parameters to specify the run time.

This cron job can be disabled by setting the `aide::nocheck` parameter.

## Reference

The following parameters are accepted by the `::aide` class:

### Installation  Options

#### `package`

Data type: String.

AIDE package name.

Default value: `aide`.

#### `version`

Data type: String.

AIDE version for installation passed to Package::ensure

Default value: `latest`.

### Configuration  Options

#### `db_path`

Data type: String.

Location of AIDE database file

Default value: `/var/lib/aide/aide.db`.

#### `db_temp_path`

Data type: String.

Location of update AIDE database file

Default value: `/var/lib/aide/aide.db.new`.

#### `gzip_dbout`

Data type: Boolean.

Gzip the AIDE database file (may affect performance)

Default value: `false`.

### Logging Options

#### `aide_log`

Data type: String.

AIDE check output log.

Default value: `/var/log/aide/aide.log`.

#### `syslogout`

Data type: Boolean.

Enables logging to the system logging service AUTH facility and `/var/log/messages`.

Default value: `true`.

### Cron scheduling Options

#### `mailto`

Data type: String.

User to set as email recipient in cron file.

Default value: `root`.

#### `minute`

Data type: Integer.

Minute of cron job to run

Default value: `0`.

#### `hour`

Data type: Integer.

Hour of cron job to run

Default value: `0`.

#### `nocheck`

Data type: Boolean.

Whether to enable or disable scheduled checks

Default value: `true`.

#### `cron_template`

Data type: String.

Puppet template file to use for cron file creation

Default value: `aide/cron.erb`.


## Hiera

Values can be set using hiera, for example:

```
aide::syslogout: false
aide::hour: 1
```

## Limitations

Currently supports RedHat / CentOS 6 & 7.

## Contributing

Pull requests for new functionality or bug fixes that follow the Puppet style guide are welcome.


## Credits

This module is a refactor based on the initial work of [Matt Lauber](https://github.com/mklauber) and uses parameter based classes rather than includes and includes additional features for:
  * custom cron entries
  * enabling gzip for database
  * allow for overrides of aide.conf and cron.d templates
  * aide logging options

