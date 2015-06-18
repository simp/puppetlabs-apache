class puppetlabs_apache::default_confd_files (
  $all = true,
) {
  # The rest of the conf.d/* files only get loaded if we want them
  if $all {
    case $::osfamily {
      'freebsd': {
        include ::puppetlabs_apache::confd::no_accf
      }
      default: {
        # do nothing
      }
    }
  }
}
