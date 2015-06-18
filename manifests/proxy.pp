# Class:puppetlabs_apache::proxy
#
# This class enabled the proxy module for Apache
#
# Actions:
#   - Enables Apache Proxy module
#
# Requires:
#
# Sample Usage:
#
class puppetlabs_apache::proxy {
  warning('apache::proxy is deprecated; please usepuppetlabs_apache::mod::proxy')
  include ::puppetlabs_apache::mod::proxy
}
