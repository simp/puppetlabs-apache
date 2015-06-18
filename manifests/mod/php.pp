class puppetlabs_apache::mod::php (
  $package_name   = undef,
  $package_ensure = 'present',
  $path           = undef,
  $extensions     = ['.php'],
) {
  if ! defined(Class['puppetlabs_apache::mod::prefork']) {
    fail('apache::mod::php requirespuppetlabs_apache::mod::prefork; please enable mpm_module => \'prefork\' on Class[\'apache\']')
  }
  validate_array($extensions)
  ::puppetlabs_apache::mod { 'php5':
    package        => $package_name,
    package_ensure => $package_ensure,
    path           => $path,
  }

  include ::puppetlabs_apache::mod::mime
  include ::puppetlabs_apache::mod::dir
  Class['::puppetlabs_apache::mod::mime'] -> Class['::puppetlabs_apache::mod::dir'] -> Class['::puppetlabs_apache::mod::php']

  # Template uses $extensions
  file { 'php5.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/php5.conf",
    content => template('puppetlabs_apache/mod/php5.conf.erb'),
    require => [
      Class['::puppetlabs_apache::mod::prefork'],
      Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    ],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
