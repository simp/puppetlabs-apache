class puppetlabs_apache::mod::xsendfile {
  include ::puppetlabs_apache::params
  ::puppetlabs_apache::mod { 'xsendfile': }
}
