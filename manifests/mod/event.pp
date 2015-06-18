class puppetlabs_apache::mod::event (
  $startservers        = '2',
  $maxclients          = '150',
  $minsparethreads     = '25',
  $maxsparethreads     = '75',
  $threadsperchild     = '25',
  $maxrequestsperchild = '0',
  $serverlimit         = '25',
  $apache_version      = $::puppetlabs_apache::apache_version,
) {
  if defined(Class['puppetlabs_apache::mod::itk']) {
    fail('May not include bothpuppetlabs_apache::mod::event andpuppetlabs_apache::mod::itk on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::peruser']) {
    fail('May not include bothpuppetlabs_apache::mod::event andpuppetlabs_apache::mod::peruser on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::prefork']) {
    fail('May not include bothpuppetlabs_apache::mod::event andpuppetlabs_apache::mod::prefork on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::worker']) {
    fail('May not include bothpuppetlabs_apache::mod::event andpuppetlabs_apache::mod::worker on the same node')
  }
  File {
    owner => 'root',
    group => $::puppetlabs_apache::params::root_group,
    mode  => '0644',
  }

  # Template uses:
  # - $startservers
  # - $maxclients
  # - $minsparethreads
  # - $maxsparethreads
  # - $threadsperchild
  # - $maxrequestsperchild
  # - $serverlimit
  file { "${::puppetlabs_apache::mod_dir}/event.conf":
    ensure  => file,
    content => template('puppetlabs_apache/mod/event.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }

  case $::osfamily {
    'redhat': {
      if versioncmp($apache_version, '2.4') >= 0 {
       puppetlabs_apache::mpm{ 'event':
          apache_version => $apache_version,
        }
      }
    }
    'debian','freebsd' : {
     puppetlabs_apache::mpm{ 'event':
        apache_version => $apache_version,
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
