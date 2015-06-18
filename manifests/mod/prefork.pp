class puppetlabs_apache::mod::prefork (
  $startservers        = '8',
  $minspareservers     = '5',
  $maxspareservers     = '20',
  $serverlimit         = '256',
  $maxclients          = '256',
  $maxrequestsperchild = '4000',
  $apache_version      = $::puppetlabs_apache::apache_version,
) {
  if defined(Class['puppetlabs_apache::mod::event']) {
    fail('May not include bothpuppetlabs_apache::mod::prefork andpuppetlabs_apache::mod::event on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::itk']) {
    fail('May not include bothpuppetlabs_apache::mod::prefork andpuppetlabs_apache::mod::itk on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::peruser']) {
    fail('May not include bothpuppetlabs_apache::mod::prefork andpuppetlabs_apache::mod::peruser on the same node')
  }
  if defined(Class['puppetlabs_apache::mod::worker']) {
    fail('May not include bothpuppetlabs_apache::mod::prefork andpuppetlabs_apache::mod::worker on the same node')
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
  file { "${::puppetlabs_apache::mod_dir}/prefork.conf":
    ensure  => file,
    content => template('puppetlabs_apache/mod/prefork.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }

  case $::osfamily {
    'redhat': {
      if versioncmp($apache_version, '2.4') >= 0 {
        ::puppetlabs_apache::mpm{ 'prefork':
          apache_version => $apache_version,
        }
      }
      else {
        file_line { '/etc/sysconfig/httpd prefork enable':
          ensure  => present,
          path    => '/etc/sysconfig/httpd',
          line    => '#HTTPD=/usr/sbin/httpd.worker',
          match   => '#?HTTPD=/usr/sbin/httpd.worker',
          require => Package['httpd'],
          notify  => Service['httpd'],
        }
      }
    }
    'debian', 'freebsd' : {
      ::puppetlabs_apache::mpm{ 'prefork':
        apache_version => $apache_version,
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
