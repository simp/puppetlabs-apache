class puppetlabs_apache::dev {
  if $::osfamily == 'FreeBSD' and !defined(Class['puppetlabs_apache::package']) {
    fail('apache::dev requirespuppetlabs_apache::package; please include apache orpuppetlabs_apache::package class first')
  }
  include ::puppetlabs_apache::params
  $packages = $::puppetlabs_apache::params::dev_packages
  package { $packages:
    ensure  => present,
    require => Package['httpd'],
  }
}
