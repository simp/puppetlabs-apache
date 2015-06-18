class puppetlabs_apache::mod::proxy_html {
  Class['::puppetlabs_apache::mod::proxy'] -> Class['::puppetlabs_apache::mod::proxy_html']
  Class['::puppetlabs_apache::mod::proxy_http'] -> Class['::puppetlabs_apache::mod::proxy_html']

  # Add libxml2
  case $::osfamily {
    /RedHat|FreeBSD/: {
      ::puppetlabs_apache::mod { 'xml2enc': }
    }
    'Debian': {
      $gnu_path = $::hardwaremodel ? {
        'i686'  => 'i386',
        default => $::hardwaremodel,
      }
      $loadfiles = $::puppetlabs_apache::params::distrelease ? {
        '6'     => ['/usr/lib/libxml2.so.2'],
        '10'    => ['/usr/lib/libxml2.so.2'],
        default => ["/usr/lib/${gnu_path}-linux-gnu/libxml2.so.2"],
      }
    }
  }

  ::puppetlabs_apache::mod { 'proxy_html':
    loadfiles => $loadfiles,
  }

  # Template uses $icons_path
  file { 'proxy_html.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/proxy_html.conf",
    content => template('puppetlabs_apache/mod/proxy_html.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
