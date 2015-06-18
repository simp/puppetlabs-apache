class puppetlabs_apache::mod::info (
  $allow_from = ['127.0.0.1','::1'],
  $apache_version = $::puppetlabs_apache::apache_version,
){
 puppetlabs_apache::mod { 'info': }
  # Template uses
  # $allow_from
  # $apache_version
  file { 'info.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/info.conf",
    content => template('puppetlabs_apache/mod/info.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
