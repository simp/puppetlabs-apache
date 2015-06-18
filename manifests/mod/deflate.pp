class puppetlabs_apache::mod::deflate {
  ::puppetlabs_apache::mod { 'deflate': }
  # Template uses no variables
  file { 'deflate.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/deflate.conf",
    content => template('puppetlabs_apache/mod/deflate.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
