# Class:puppetlabs_apache::php
#
# This class installs PHP for Apache
#
# Parameters:
# - $php_package
#
# Actions:
#   - Install Apache PHP package
#
# Requires:
#
# Sample Usage:
#
class puppetlabs_apache::php {
  warning('apache::php is deprecated; please usepuppetlabs_apache::mod::php')
  include ::puppetlabs_apache::mod::php
}
