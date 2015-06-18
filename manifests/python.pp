# Class:puppetlabs_apache::python
#
# This class installs Python for Apache
#
# Parameters:
# - $php_package
#
# Actions:
#   - Install Apache Python package
#
# Requires:
#
# Sample Usage:
#
class puppetlabs_apache::python {
  warning('apache::python is deprecated; please usepuppetlabs_apache::mod::python')
  include ::puppetlabs_apache::mod::python
}
