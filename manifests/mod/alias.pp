class puppetlabs_apache::mod::alias(
  $apache_version = $puppetlabs_apache::apache_version
) {
  $icons_path = $::osfamily ? {
    'debian'  => '/usr/share/apache2/icons',
    'redhat'  => '/var/www/icons',
    'freebsd' => '/usr/local/www/apache22/icons',
  }
 puppetlabs_apache::mod { 'alias': }
  # Template uses $icons_path
  file { 'alias.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/alias.conf",
    content => template('puppetlabs_apache/mod/alias.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
