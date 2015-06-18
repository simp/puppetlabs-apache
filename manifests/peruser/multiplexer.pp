define puppetlabs_apache::peruser::multiplexer (
  $user = $::puppetlabs_apache::user,
  $group = $::puppetlabs_apache::group,
  $file = undef,
) {
  if ! $file {
    $filename = "${name}.conf"
  } else {
    $filename = $file
  }
  file { "${::puppetlabs_apache::mod_dir}/peruser/multiplexers/${filename}":
    ensure  => file,
    content => "Multiplexer ${user} ${group}\n",
    require => File["${::puppetlabs_apache::mod_dir}/peruser/multiplexers"],
    notify  => Service['httpd'],
  }
}
