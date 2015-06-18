class puppetlabs_apache::mod::ldap {
  ::puppetlabs_apache::mod { 'ldap': }
  # Template uses no variables
  file { 'ldap.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/ldap.conf",
    content => template('puppetlabs_apache/mod/ldap.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
