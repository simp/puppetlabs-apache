# Class:puppetlabs_apache::ssl
#
# This class installs Apache SSL capabilities
#
# Parameters:
# - The $ssl_package name from thepuppetlabs_apache::params class
#
# Actions:
#   - Install Apache SSL capabilities
#
# Requires:
#
# Sample Usage:
#
class puppetlabs_apache::ssl {
  warning('apache::ssl is deprecated; please usepuppetlabs_apache::mod::ssl')
  include ::puppetlabs_apache::mod::ssl
}
