class puppetlabs_apache::mod::proxy_ajp {
  Class['::puppetlabs_apache::mod::proxy'] -> Class['::puppetlabs_apache::mod::proxy_ajp']
  ::puppetlabs_apache::mod { 'proxy_ajp': }
}
