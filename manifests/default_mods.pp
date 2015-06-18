class puppetlabs_apache::default_mods (
  $all            = true,
  $mods           = undef,
  $apache_version = $::puppetlabs_apache::apache_version
) {
  # These are modules required to run the default configuration.
  # They are not configurable at this time, so we just include
  # them to make sure it works.
  case $::osfamily {
    'redhat', 'freebsd': {
      ::puppetlabs_apache::mod { 'log_config': }
      if versioncmp($apache_version, '2.4') >= 0 {
        # Lets fork it
        ::puppetlabs_apache::mod { 'systemd': }
        ::puppetlabs_apache::mod { 'unixd': }
      }
    }
    default: {}
  }
  ::puppetlabs_apache::mod { 'authz_host': }

  # The rest of the modules only get loaded if we want all modules enabled
  if $all {
    case $::osfamily {
      'debian': {
        include ::puppetlabs_apache::mod::reqtimeout
      }
      'redhat': {
        include ::puppetlabs_apache::mod::actions
        include ::puppetlabs_apache::mod::cache
        include ::puppetlabs_apache::mod::mime
        include ::puppetlabs_apache::mod::mime_magic
        include ::puppetlabs_apache::mod::vhost_alias
        include ::puppetlabs_apache::mod::suexec
        include ::puppetlabs_apache::mod::rewrite
        include ::puppetlabs_apache::mod::speling
        ::puppetlabs_apache::mod { 'auth_digest': }
        ::puppetlabs_apache::mod { 'authn_anon': }
        ::puppetlabs_apache::mod { 'authn_dbm': }
        ::puppetlabs_apache::mod { 'authz_dbm': }
        ::puppetlabs_apache::mod { 'authz_owner': }
        ::puppetlabs_apache::mod { 'expires': }
        ::puppetlabs_apache::mod { 'ext_filter': }
        ::puppetlabs_apache::mod { 'include': }
        ::puppetlabs_apache::mod { 'logio': }
        ::puppetlabs_apache::mod { 'substitute': }
        ::puppetlabs_apache::mod { 'usertrack': }
        ::puppetlabs_apache::mod { 'version': }

        if versioncmp($apache_version, '2.4') >= 0 {
          ::puppetlabs_apache::mod { 'authn_core': }
        }
        else {
          ::puppetlabs_apache::mod { 'authn_alias': }
          ::puppetlabs_apache::mod { 'authn_default': }
        }
      }
      'freebsd': {
        include ::puppetlabs_apache::mod::actions
        include ::puppetlabs_apache::mod::cache
        include ::puppetlabs_apache::mod::disk_cache
        include ::puppetlabs_apache::mod::headers
        include ::puppetlabs_apache::mod::info
        include ::puppetlabs_apache::mod::mime_magic
        include ::puppetlabs_apache::mod::reqtimeout
        include ::puppetlabs_apache::mod::rewrite
        include ::puppetlabs_apache::mod::userdir
        include ::puppetlabs_apache::mod::vhost_alias
        include ::puppetlabs_apache::mod::speling

        ::puppetlabs_apache::mod { 'asis': }
        ::puppetlabs_apache::mod { 'auth_digest': }
        ::puppetlabs_apache::mod { 'authn_alias': }
        ::puppetlabs_apache::mod { 'authn_anon': }
        ::puppetlabs_apache::mod { 'authn_dbm': }
        ::puppetlabs_apache::mod { 'authn_default': }
        ::puppetlabs_apache::mod { 'authz_dbm': }
        ::puppetlabs_apache::mod { 'authz_owner': }
        ::puppetlabs_apache::mod { 'cern_meta': }
        ::puppetlabs_apache::mod { 'charset_lite': }
        ::puppetlabs_apache::mod { 'dumpio': }
        ::puppetlabs_apache::mod { 'expires': }
        ::puppetlabs_apache::mod { 'file_cache': }
        ::puppetlabs_apache::mod { 'filter':}
        ::puppetlabs_apache::mod { 'imagemap':}
        ::puppetlabs_apache::mod { 'include': }
        ::puppetlabs_apache::mod { 'logio': }
        ::puppetlabs_apache::mod { 'unique_id': }
        ::puppetlabs_apache::mod { 'usertrack': }
        ::puppetlabs_apache::mod { 'version': }
      }
      default: {}
    }
    case $::puppetlabs_apache::mpm_module {
      'prefork': {
        include ::puppetlabs_apache::mod::cgi
      }
      'worker': {
        include ::puppetlabs_apache::mod::cgid
      }
      default: {
        # do nothing
      }
    }
    include ::puppetlabs_apache::mod::alias
    include ::puppetlabs_apache::mod::autoindex
    include ::puppetlabs_apache::mod::dav
    include ::puppetlabs_apache::mod::dav_fs
    include ::puppetlabs_apache::mod::deflate
    include ::puppetlabs_apache::mod::dir
    include ::puppetlabs_apache::mod::mime
    include ::puppetlabs_apache::mod::negotiation
    include ::puppetlabs_apache::mod::setenvif
    ::puppetlabs_apache::mod { 'auth_basic': }
    ::puppetlabs_apache::mod { 'authn_file': }

      if versioncmp($apache_version, '2.4') >= 0 {
      # authz_core is needed for 'Require' directive
      ::puppetlabs_apache::mod { 'authz_core':
        id => 'authz_core_module',
      }

      # filter is needed by mod_deflate
      ::puppetlabs_apache::mod { 'filter': }

      # lots of stuff seems to break without access_compat
      ::puppetlabs_apache::mod { 'access_compat': }
    } else {
      ::puppetlabs_apache::mod { 'authz_default': }
    }

    ::puppetlabs_apache::mod { 'authz_groupfile': }
    ::puppetlabs_apache::mod { 'authz_user': }
    ::puppetlabs_apache::mod { 'env': }
  } elsif $mods {
    ::puppetlabs_apache::default_mods::load { $mods: }

    if versioncmp($apache_version, '2.4') >= 0 {
      # authz_core is needed for 'Require' directive
      ::puppetlabs_apache::mod { 'authz_core':
        id => 'authz_core_module',
      }

      # filter is needed by mod_deflate
      ::puppetlabs_apache::mod { 'filter': }
    }
  } else {
    if versioncmp($apache_version, '2.4') >= 0 {
      # authz_core is needed for 'Require' directive
      ::puppetlabs_apache::mod { 'authz_core':
        id => 'authz_core_module',
      }

      # filter is needed by mod_deflate
      ::puppetlabs_apache::mod { 'filter': }
    }
  }
}
