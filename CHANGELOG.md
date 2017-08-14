warrenpz/aide-1.0.4
==================
  - Added Puppet forge tags
  - README updates for typos
  - Additional examples
  - Spec test fixes

warrenpz/aide-1.0.3
==================
  - Updated ordering in conf file of exclude rules to group them together for readability.
    the way that AIDE handles rules internally does not matter where rules are in the
    config file, but it is easier to read if they are together.

warrenpz/aide-1.0.2
==================

 - Refactored module classes to be parameter based
 - Updated template for conf file to include AIDE help info
 - Examples added

mklauber/aide-1.1.0
==================

 - Refactored the aide::watch type to accept a `type` param instead of the `excludes` param.  
    - This provided support for 'equals' directory specifications.

mklauber/aide-1.0.0
==================

 - Support for Debian based OS's
 - Support for Redhat based Os's
