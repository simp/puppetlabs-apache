class puppetlabs_apache::mod::disk_cache {
  $cache_root = $::osfamily ? {
    'debian'  => '/var/cache/apache2/mod_disk_cache',
    'redhat'  => '/var/cache/mod_proxy',
    'freebsd' => '/var/cache/mod_disk_cache',
  }
  if $::osfamily != 'FreeBSD' {
    # FIXME: investigate why disk_cache was dependent on proxy
    # NOTE: on FreeBSD disk_cache is compiled by default but proxy is not
    Class['::puppetlabs_apache::mod::proxy'] -> Class['::puppetlabs_apache::mod::disk_cache']
  }
  Class['::puppetlabs_apache::mod::cache'] -> Class['::puppetlabs_apache::mod::disk_cache']

 puppetlabs_apache::mod { 'disk_cache': }
  # Template uses $cache_proxy
  file { 'disk_cache.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/disk_cache.conf",
    content => template('puppetlabs_apache/mod/disk_cache.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
