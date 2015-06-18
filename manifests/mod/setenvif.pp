class puppetlabs_apache::mod::setenvif {
  ::puppetlabs_apache::mod { 'setenvif': }
  # Template uses no variables
  file { 'setenvif.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/setenvif.conf",
    content => template('puppetlabs_apache/mod/setenvif.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
