class puppetlabs_apache::mod::fastcgi {

  # Debian specifies it's fastcgi lib path, but RedHat uses the default value
  # with no config file
  $fastcgi_lib_path = $::puppetlabs_apache::params::fastcgi_lib_path

  ::puppetlabs_apache::mod { 'fastcgi': }

  if $fastcgi_lib_path {
    # Template uses:
    # - $fastcgi_server
    # - $fastcgi_socket
    # - $fastcgi_dir
    file { 'fastcgi.conf':
      ensure  => file,
      path    => "${::puppetlabs_apache::mod_dir}/fastcgi.conf",
      content => template('puppetlabs_apache/mod/fastcgi.conf.erb'),
      require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
      before  => File[$::puppetlabs_apache::mod_dir],
      notify  => Service['httpd'],
    }
  }

}
