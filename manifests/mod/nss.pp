class puppetlabs_apache::mod::nss (
  $transfer_log = "${::puppetlabs_apache::params::logroot}/access.log",
  $error_log    = "${::puppetlabs_apache::params::logroot}/error.log",
  $passwd_file  = undef
) {
  include ::puppetlabs_apache::mod::mime

 puppetlabs_apache::mod { 'nss': }

  $httpd_dir = $::puppetlabs_apache::httpd_dir

  # Template uses:
  # $transfer_log
  # $error_log
  # $http_dir
  # passwd_file
  file { 'nss.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/nss.conf",
    content => template('puppetlabs_apache/mod/nss.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
