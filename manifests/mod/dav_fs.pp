class puppetlabs_apache::mod::dav_fs {
  $dav_lock = $::osfamily ? {
    'debian'  => '${APACHE_LOCK_DIR}/DAVLock',
    'freebsd' => '/usr/local/var/DavLock',
    default   => '/var/lib/dav/lockdb',
  }

  Class['::puppetlabs_apache::mod::dav'] -> Class['::puppetlabs_apache::mod::dav_fs']
  ::puppetlabs_apache::mod { 'dav_fs': }

  # Template uses: $dav_lock
  file { 'dav_fs.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/dav_fs.conf",
    content => template('puppetlabs_apache/mod/dav_fs.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
