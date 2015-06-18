class puppetlabs_apache::mod::rewrite {
  include ::puppetlabs_apache::params
  ::puppetlabs_apache::mod { 'rewrite': }
}
