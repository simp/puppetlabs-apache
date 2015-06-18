class puppetlabs_apache::mod::suphp (
){
  ::puppetlabs_apache::mod { 'suphp': }

  file {'suphp.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/suphp.conf",
    content => template('puppetlabs_apache/mod/suphp.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd']
  }
}

