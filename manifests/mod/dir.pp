# Note: this sets the global DirectoryIndex directive, it may be necessary to consider being able to modify thepuppetlabs_apache::vhost to declare DirectoryIndex statements in a vhost configuration
# Parameters:
# - $indexes provides a string for the DirectoryIndex directive http://httpd.apache.org/docs/current/mod/mod_dir.html#directoryindex
class puppetlabs_apache::mod::dir (
  $dir     = 'public_html',
  $indexes = ['index.html','index.html.var','index.cgi','index.pl','index.php','index.xhtml'],
) {
  validate_array($indexes)
  ::puppetlabs_apache::mod { 'dir': }

  # Template uses
  # - $indexes
  file { 'dir.conf':
    ensure  => file,
    path    => "${::puppetlabs_apache::mod_dir}/dir.conf",
    content => template('puppetlabs_apache/mod/dir.conf.erb'),
    require => Exec["mkdir ${::puppetlabs_apache::mod_dir}"],
    before  => File[$::puppetlabs_apache::mod_dir],
    notify  => Service['httpd'],
  }
}
