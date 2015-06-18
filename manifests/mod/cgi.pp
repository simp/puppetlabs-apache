class puppetlabs_apache::mod::cgi {
  Class['::puppetlabs_apache::mod::prefork'] -> Class['::puppetlabs_apache::mod::cgi']
  ::puppetlabs_apache::mod { 'cgi': }
}
