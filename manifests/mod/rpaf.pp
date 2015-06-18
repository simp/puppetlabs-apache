class puppetlabs_apache::mod::rpaf (
  $sethostname = true,
  $proxy_ips   = [ '127.0.0.1' ],
  $header      = 'X-Forwarded-For'
) {
  ::puppetlabs_apache::mod { 'rpaf': }

  # Template uses:
  # - $sethostname
  # - $proxy_ips
  # - $header
  file { 'rpaf.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/rpaf.conf",
    content => template('puppetlabs_apache/mod/rpaf.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
