class puppetlabs_apache::mod::reqtimeout {
  ::puppetlabs_apache::mod { 'reqtimeout': }
  # Template uses no variables
  file { 'reqtimeout.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/reqtimeout.conf",
    content => template('puppetlabs_apache/mod/reqtimeout.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
