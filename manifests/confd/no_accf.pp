class puppetlabs_apache::confd::no_accf {
  # Template uses no variables
  file { 'no-accf.conf':
    ensure  => 'file',
    path    => "${::puppetlabs_apache::confd_dir}/no-accf.conf",
    content => template('puppetlabs_apache/confd/no-accf.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::confd_dir}"],
    before  => File[$::puppetlabs_apache::confd_dir],
  }
}
