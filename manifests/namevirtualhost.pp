define puppetlabs_apache::namevirtualhost {
  $addr_port = $name

  # Template uses: $addr_port
#  concat::fragment { "NameVirtualHost ${addr_port}":
#    ensure  => present,
#    target  => $::puppetlabs_apache::ports_file,
#    content => template('puppetlabs_apache/namevirtualhost.erb'),
#  }
  concat_fragment { "plabs_apache_ports+apache_namevirtualhost":
    content => template('puppetlabs_apache/namevirtualhost.erb')
  }
}
