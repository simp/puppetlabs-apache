class puppetlabs_apache::mod::dev {
  # Development packages are not apache modules
  warning('apache::mod::dev is deprecated; please usepuppetlabs_apache::dev')
  include ::puppetlabs_apache::dev
}
