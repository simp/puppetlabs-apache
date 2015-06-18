class puppetlabs_apache::mod::itk (
  $startservers        = '8',
  $minspareservers     = '5',
  $maxspareservers     = '20',
  $serverlimit         = '256',
  $maxclients          = '256',
  $maxrequestsperchild = '4000',
  $apache_version      = $::puppetlabs_apache::apache_version,
) {
  if defined(Class['puppetlabs_apache::mod::event']) {
    fail('May not include bothpuppetlabs_apache::mod::itk andpuppetlabs_apache::mod::event on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::peruser']) {
    fail('May not include bothpuppetlabs_apache::mod::itk andpuppetlabs_apache::mod::peruser on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::prefork']) {
    fail('May not include bothpuppetlabs_apache::mod::itk andpuppetlabs_apache::mod::prefork on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::worker']) {
    fail('May not include bothpuppetlabs_apache::mod::itk andpuppetlabs_apache::mod::worker on the same node')
  }
  File {
    owner => 'root',
    group => $::puppetlabs_apache::params::root_group,
    mode  => '0644',
  }

  # Template uses:
  # - $startservers
  # - $minspareservers
  # - $maxspareservers
  # - $serverlimit
  # - $maxclients
  # - $maxrequestsperchild
  file { "${::puppetlabs_apache::mod_dir}/itk.conf":
    ensure  => file,
    content => template('puppetlabs_apache/mod/itk.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }

  case $::osfamily {
    'debian', 'freebsd': {
     puppetlabs_apache::mpm{ 'itk':
        apache_version => $apache_version,
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
