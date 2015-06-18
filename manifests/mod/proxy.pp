class puppetlabs_apache::mod::proxy (
  $proxy_requests = 'Off',
  $allow_from = undef,
) {
  ::puppetlabs_apache::mod { 'proxy': }
  # Template uses $proxy_requests
  file { 'proxy.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/proxy.conf",
    content => template('puppetlabs_apache/mod/proxy.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
