# == Define Resource Type:puppetlabs_apache::balancer
#
# This type will create an apache balancer cluster file inside the conf.d
# directory. Each balancer cluster needs one or more balancer members (that can
# be declared with thepuppetlabs_apache::balancermember defined resource type). Using
# storeconfigs, you can export thepuppetlabs_apache::balancermember resources on all
# balancer members, and then collect them on a single apache load balancer
# server.
#
# === Requirement/Dependencies:
#
# Currently requires the puppetlabs/concat module on the Puppet Forge and uses
# storeconfigs on the Puppet Master to export/collect resources from all
# balancer members.
#
# === Parameters
#
# [*name*]
# The namevar of the defined resource type is the balancer clusters name.
# This name is also used in the name of the conf.d file
#
# [*proxy_set*]
# Hash, default empty. If given, each key-value pair will be used as a ProxySet
# line in the configuration.
#
# [*collect_exported*]
# Boolean, default 'true'. True means 'collect exported @@balancermember
# resources' (for the case when every balancermember node exports itself),
# false means 'rely on the existing declared balancermember resources' (for the
# case when you know the full set of balancermembers in advance and use
#puppetlabs_apache::balancermember with array arguments, which allows you to deploy
# everything in 1 run)
#
#
# === Examples
#
# Exporting the resource for a balancer member:
#
#puppetlabs_apache::balancer { 'puppet00': }
#
define puppetlabs_apache::balancer (
  $proxy_set = {},
  $collect_exported = true,
) {
  include concat::setup
  include ::puppetlabs_apache::mod::proxy_balancer

  $target = "${::puppetlabs_apache::params::confd_dir}/balancer_${name}.conf"

#  concat { $target:
#    owner  => '0',
#    group  => '0',
#    mode   => '0644',
#    notify => Service['httpd'],
#  }
#
#  concat::fragment { "00-${name}-header":
#    ensure  => present,
#    target  => $target,
#    order   => '01',
#    content => "<Proxy balancer://${name}>\n",
#  }

  concat_build { "plabs_apache_balancer":
    target => $target
  }

  concat_fragment { "plabs_apache_balancer+proxy_header":
    content => "<Proxy balancer://${name}>\n"
  }

  if $collect_exported {
    Puppetlabs_apache::Balancermember <<| balancer_cluster == $name |>>
  }
  # else: the resources have been created and they introduced their
  # concat fragments. We don't have to do anything about them.

#  concat::fragment { "01-${name}-proxyset":
#    ensure  => present,
#    target  => $target,
#    order   => '19',
#    content => inline_template("<% proxy_set.keys.sort.each do |key| %> Proxyset <%= key %>=<%= proxy_set[key] %>\n<% end %>"),
#  }

  concat_fragment { "plabs_apache_balancer+proxy_set":
    content => inline_template("<% proxy_set.keys.sort.each do |key| %> Proxyset <%= key %>=<%= proxy_set[key] %>\n<% end %>")
  }

#  concat::fragment { "01-${name}-footer":
#    ensure  => present,
#    target  => $target,
#    order   => '20',
#    content => "</Proxy>\n",
#  }

  concat_fragment { "plabs_apache_balancer+proxy_footer":
    content => "</Proxy>\n"
  }
}
