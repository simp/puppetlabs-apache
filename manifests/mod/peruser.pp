class puppetlabs_apache::mod::peruser (
  $minspareprocessors = '2',
  $minprocessors = '2',
  $maxprocessors = '10',
  $maxclients = '150',
  $maxrequestsperchild = '1000',
  $idletimeout = '120',
  $expiretimeout = '120',
  $keepalive = 'Off',
) {
  if defined(Class['puppetlabs_apache::mod::event']) {
    fail('May not include bothpuppetlabs_apache::mod::peruser andpuppetlabs_apache::mod::event on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::itk']) {
    fail('May not include bothpuppetlabs_apache::mod::peruser andpuppetlabs_apache::mod::itk on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::prefork']) {
    fail('May not include bothpuppetlabs_apache::mod::peruser andpuppetlabs_apache::mod::prefork on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::worker']) {
    fail('May not include bothpuppetlabs_apache::mod::peruser andpuppetlabs_apache::mod::worker on the same node')
  }
  File {
    owner => 'root',
    group => $::puppetlabs_apache::params::root_group,
    mode  => '0644',
  }

  $mod_dir = $::puppetlabs_apache::mod_dir

  # Template uses:
  # - $minspareprocessors
  # - $minprocessors
  # - $maxprocessors
  # - $maxclients
  # - $maxrequestsperchild
  # - $idletimeout
  # - $expiretimeout
  # - $keepalive
  # - $mod_dir
  file { "${::puppetlabs_apache::mod_dir}/peruser.conf":
    ensure  => file,
    content => template('puppetlabs_apache/mod/peruser.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
  file { "${::puppetlabs_apache::mod_dir}/peruser":
    ensure  => directory,
    require => File[$::puppetlabs_apache::mod_dir],
  }
  file { "${::puppetlabs_apache::mod_dir}/peruser/multiplexers":
    ensure  => directory,
    require => File["${::puppetlabs_apache::mod_dir}/peruser"],
  }
  file { "${::puppetlabs_apache::mod_dir}/peruser/processors":
    ensure  => directory,
    require => File["${::puppetlabs_apache::mod_dir}/peruser"],
  }

  ::puppetlabs_apache::peruser::multiplexer { '01-default': }

  case $::osfamily {
    'freebsd' : {
      class { '::puppetlabs_apache::package':
        mpm_module => 'peruser'
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
