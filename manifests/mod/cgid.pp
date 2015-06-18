class puppetlabs_apache::mod::cgid {
  Class['::puppetlabs_apache::mod::worker'] -> Class['::puppetlabs_apache::mod::cgid']

  # Debian specifies it's cgid sock path, but RedHat uses the default value
  # with no config file
  $cgisock_path = $::osfamily ? {
    'debian'  => '${APACHE_RUN_DIR}/cgisock',
    'freebsd' => 'cgisock',
    default   => undef,
  }
  ::puppetlabs_apache::mod { 'cgid': }
  if $cgisock_path {
    # Template uses $cgisock_path
    file { 'cgid.conf':
      ensure  => file,
      path    => "${::puppetlabs_apache::mod_dir}/cgid.conf",
      content => template('puppetlabs_apache/mod/cgid.conf.erb'),
      require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
      before  => File[$::puppetlabs_apache::mod_dir],
      notify  => Service['httpd'],
    }
  }
}
