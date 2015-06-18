class puppetlabs_apache::mod::negotiation {
  ::puppetlabs_apache::mod { 'negotiation': }
  # Template uses no variables
  file { 'negotiation.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/negotiation.conf",
    content => template('puppetlabs_apache/mod/negotiation.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
