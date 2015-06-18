class puppetlabs_apache::mod::dav_svn {
  Class['::puppetlabs_apache::mod::dav'] -> Class['::puppetlabs_apache::mod::dav_svn']
  include ::puppetlabs_apache::mod::dav
  ::puppetlabs_apache::mod { 'dav_svn': }
}
