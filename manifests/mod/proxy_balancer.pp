class puppetlabs_apache::mod::proxy_balancer {

  include ::puppetlabs_apache::mod::proxy
  include ::puppetlabs_apache::mod::proxy_http

  Class['::puppetlabs_apache::mod::proxy'] -> Class['::puppetlabs_apache::mod::proxy_balancer']
  Class['::puppetlabs_apache::mod::proxy_http'] -> Class['::puppetlabs_apache::mod::proxy_balancer']
  ::puppetlabs_apache::mod { 'proxy_balancer': }

}
