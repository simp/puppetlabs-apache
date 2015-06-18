class puppetlabs_apache::mod::userdir (
  $home = '/home',
  $dir = 'public_html',
  $disable_root = true,
) {
  ::puppetlabs_apache::mod { 'userdir': }

  # Template uses $home, $dir, $disable_root
  file { 'userdir.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/userdir.conf",
    content => template('puppetlabs_apache/mod/userdir.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
