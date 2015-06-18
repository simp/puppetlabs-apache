# private define
define puppetlabs_apache::default_mods::load ($module = $title) {
  if defined("::puppetlabs_apache::mod::${module}") {
    include "::puppetlabs_apache::mod::${module}"
  } else {
    ::puppetlabs_apache::mod { $module: }
  }
}
