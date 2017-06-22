# AIDE - Advanced Intrusion Detection Enviroment.

#### Table of Contents

1. [Description](#description)
2. [Examples](#examples)
3. [Cron Entry](#cron)
4. [Assigning parameters using Hiera](#heira)
5. [Limitations](#limitations)
6. [Contributing to the development of this module](#contributors)
7. [Credits](#Credits)

## Description

This is a module for managing the installation, configuration and initial database creation of the [AIDE](http://aide.sourceforge.net/) (Advanced Intrustion Detection Environment) package.

AIDE creates a database of files and their attributes from the rules that it finds in its config file. Once this database is initialized, it can be used to verify the integrity of the files contained within it. If the file attributes change according to the rules supplied, a summary of changes is logged and can be acted upon.

Refer to the [AIDE manual](http://aide.sourceforge.net/stable/manual.html) for further details about configuration options.

The module will also add a cron job to periodically run the `aide --check` command to verify the integrity of the AIDE database. Results will be logged to the log file (defaults to `/var/log/aide/aide.log`) and to the AUTH log facility.

## Examples

==========

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

