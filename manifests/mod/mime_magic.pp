class puppetlabs_apache::mod::mime_magic (
  $magic_file = "${::puppetlabs_apache::params::conf_dir}/magic"
) {
 puppetlabs_apache::mod { 'mime_magic': }
  # Template uses $magic_file
  file { 'mime_magic.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/mime_magic.conf",
    content => template('puppetlabs_apache/mod/mime_magic.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
