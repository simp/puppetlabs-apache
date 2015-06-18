class puppetlabs_apache::mod::wsgi (
  $wsgi_socket_prefix = undef,
  $wsgi_python_path   = undef,
  $wsgi_python_home   = undef,
){
  ::puppetlabs_apache::mod { 'wsgi': }

  # Template uses:
  # - $wsgi_socket_prefix
  # - $wsgi_python_path
  # - $wsgi_python_home
  file {'wsgi.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/wsgi.conf",
    content => template('puppetlabs_apache/mod/wsgi.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd']
  }
}

