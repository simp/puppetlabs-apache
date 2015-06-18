class puppetlabs_apache::mod::proxy_http {
  Class['::puppetlabs_apache::mod::proxy'] -> Class['::puppetlabs_apache::mod::proxy_http']
  ::puppetlabs_apache::mod { 'proxy_http': }
}
