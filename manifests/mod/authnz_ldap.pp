class puppetlabs_apache::mod::authnz_ldap (
  $verifyServerCert = true,
) {
  include '::puppetlabs_apache::mod::ldap'
  ::puppetlabs_apache::mod { 'authnz_ldap': }

  validate_bool($verifyServerCert)

  # Template uses:
  # - $verifyServerCert
  file { 'authnz_ldap.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/authnz_ldap.conf",
    content => template('puppetlabs_apache/mod/authnz_ldap.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
