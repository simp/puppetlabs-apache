# Class:puppetlabs_apache::service
#
# Manages the Apache daemon
#
# Parameters:
#
# Actions:
#   - Manage Apache service
#
# Requires:
#
# Sample Usage:
#
#    sometype { 'foo':
#      notify => Class['puppetlabs_apache::service'],
#    }
#
#
class puppetlabs_apache::service (
  $service_name   = $::puppetlabs_apache::params::service_name,
  $service_enable = true,
  $service_ensure = 'running',
) {
  # The base class must be included first because parameter defaults depend on it
  if ! defined(Class['puppetlabs_apache::params']) {
    fail('You must include thepuppetlabs_apache::params class before using any apache defined resources')
  }
  validate_bool($service_enable)

  case $service_ensure {
    true, false, 'running', 'stopped': {
      $_service_ensure = $service_ensure
    }
    default: {
      $_service_ensure = undef
    }
  }

  service { 'httpd':
    ensure => $_service_ensure,
    name   => $service_name,
    enable => $service_enable,
  }
}
