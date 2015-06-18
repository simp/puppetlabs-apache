class { 'apache':
  mpm_module => 'prefork',
}
includepuppetlabs_apache::mod::php
