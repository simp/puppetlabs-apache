class puppetlabs_apache::mod::autoindex {
  ::puppetlabs_apache::mod { 'autoindex': }
  # Template uses no variables
  file { 'autoindex.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/autoindex.conf",
    content => template('puppetlabs_apache/mod/autoindex.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
