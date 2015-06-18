class puppetlabs_apache::mod::mime (
  $mime_support_package = $::puppetlabs_apache::params::mime_support_package,
  $mime_types_config    = $::puppetlabs_apache::params::mime_types_config,
) {
 puppetlabs_apache::mod { 'mime': }
  # Template uses $mime_types_config
  file { 'mime.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/mime.conf",
    content => template('puppetlabs_apache/mod/mime.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
  if $mime_support_package {
    package { $mime_support_package:
      ensure => 'installed',
      before => File['mime.conf'],
    }
  }
}
