define puppetlabs_apache::listen {
  $listen_addr_port = $name

  # Template uses: $listen_addr_port
#  concat::fragment { "Listen ${listen_addr_port}":
#    ensure  => present,
#    target  => $::puppetlabs_apache::ports_file,
#    content => template('puppetlabs_apache/listen.erb'),
#  }
  concat_fragment { "plabs_apache_ports+apache_listen":
    content => template('puppetlabs_apache/listen.erb')
  }
}
