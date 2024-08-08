# @summary A class for configuring facter.conf
#
# Configures facter.conf based on settings available at https://www.puppet.com/docs/puppet/latest/configuring_facter.html
#
# @param facter_conf_ensure
#
#  Sets whether to ensure facter.conf is present or absent
#
# @param config_path
#
#  Path for configuring facter.conf
#
# @param owner
#
#  Owner of facter.conf file
#
# @param group
#
#  Group of facter.conf file
#
# @param mode
#
#  Mode of facter.conf file
#
# @param facts_blocklist
#
#  Optional array for setting facts to block
#
# @param facts_ttls
#
#  Optional array of hashes for setting the time to live (ttl) for given facts.  This will cache the facts listed for the given duration.
#
# @param global_external_dir
#
#  Optional array of paths to search in for external facts
#
# @param global_custom_dir
#
#  Optional array of paths to search in for custom facts
#
# @param global_no_external_facts
#
#  Optional boolean. If true, prevents Facter from searching for external facts.
#
# @param global_no_custom_facts
#
#  Optional boolean.  If true, prevents Facter from searching for custom facts.
#
# @param global_no_ruby
#
#  Optional boolean.  If true, prevents Facter from loading its Ruby functionality.
#
# @param cli_debug
#
#  Optional boolean.  If true, Facter outputs debug messages.
#
# @param cli_trace
#
#  Optional boolean.  If true, Facter prints stacktraces from errors arising in your custom facts.
#
# @param cli_verbose
#
#  Optional boolean.  If true, Facter outputs its most detailed messages.
#
# @param cli_log_level
#
#  Sets the minimum level of message severity that gets logged. Valid options: "none", "fatal", "error", "warn", "info", "debug", "trace".
#
# @param fact_groups
#
#  Definition of custom fact groups which can be used for blocking (blocklist) or caching (ttls) groups of facts.
#
# @example
#   include facter_conf
class facter_conf (
  Enum['present','absent']   $facter_conf_ensure = 'present',
  String[1]                  $config_path = '/etc/puppetlabs/facter',
  String[1]                  $owner = 'root',
  String[1]                  $group = 'root',
  String[1]                  $mode = '0644',
  Optional[Array[String[1]]] $facts_blocklist = undef,
  Optional[Array[Hash]]      $facts_ttls = undef,
  Optional[Array[String[1]]] $global_external_dir = undef,
  Optional[Array[String[1]]] $global_custom_dir = undef,
  Optional[Boolean]          $global_no_external_facts = undef,
  Optional[Boolean]          $global_no_custom_facts = undef,
  Optional[Boolean]          $global_no_ruby = undef,
  Optional[Boolean]          $cli_debug = undef,
  Optional[Boolean]          $cli_trace = undef,
  Optional[Boolean]          $cli_verbose = undef,
  Optional[
    Enum[
      'none',
      'fatal',
      'error',
      'warn',
      'info',
      'debug',
      'trace'
    ]
  ]                         $cli_log_level = undef,
  Optional[
    Array[
      Struct[
        {
          name => String[1],
          facts => Array[String[1]],
        }
      ]
    ]
  ]                          $fact_groups = undef,
) {
  $facter_conf_path = "${config_path}/facter.conf"
  $facter_conf_file_ensure = $facter_conf_ensure ? {
    'present' => file,
    default   => absent,
  }

  file { $config_path:
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  file { $facter_conf_path:
    ensure => $facter_conf_file_ensure,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  if $facter_conf_ensure == 'present' {
    if $facts_blocklist != undef {
      hocon_setting { 'facter_conf.facts.blocklist':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'facts.blocklist',
        type    => 'array',
        value   => $facts_blocklist,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.facts.blocklist':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'facts.blocklist',
        type    => 'array',
        require => File[$facter_conf_path],
      }
    }

    if $facts_ttls != undef {
      hocon_setting { 'facter_conf.facts.ttls':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'facts.ttls',
        type    => 'array',
        value   => $facts_ttls,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.facts.ttls':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'facts.ttls',
        type    => 'array',
        require => File[$facter_conf_path],
      }
    }

    if $global_external_dir != undef {
      hocon_setting { 'facter_conf.global.external-dir':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'global.external-dir',
        type    => 'array',
        value   => $global_external_dir,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.global.external-dir':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'global.external-dir',
        type    => 'array',
        require => File[$facter_conf_path],
      }
    }

    if $global_custom_dir != undef {
      hocon_setting { 'facter_conf.global.custom-dir':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'global.custom-dir',
        type    => 'array',
        value   => $global_custom_dir,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.global.custom-dir':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'global.custom-dir',
        type    => 'array',
        require => File[$facter_conf_path],
      }
    }

    if $global_no_external_facts != undef {
      hocon_setting { 'facter_conf.global.no-external-facts':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'global.no-external-facts',
        type    => 'boolean',
        value   => $global_no_external_facts,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.global.no-external-facts':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'global.no-external-facts',
        type    => 'boolean',
        require => File[$facter_conf_path],
      }
    }

    if $global_no_custom_facts != undef {
      hocon_setting { 'facter_conf.global.no-custom-facts':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'global.no-custom-facts',
        type    => 'boolean',
        value   => $global_no_custom_facts,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.global.no-custom-facts':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'global.no-custom-facts',
        type    => 'boolean',
        require => File[$facter_conf_path],
      }
    }

    if $global_no_ruby != undef {
      hocon_setting { 'facter_conf.global.no-ruby':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'global.no-ruby',
        type    => 'boolean',
        value   => $global_no_ruby,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.global.no-ruby':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'global.no-ruby',
        type    => 'boolean',
        require => File[$facter_conf_path],
      }
    }

    if $cli_debug != undef {
      hocon_setting { 'facter_conf.cli.debug':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'cli.debug',
        type    => 'boolean',
        value   => $cli_debug,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.cli.debug':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'cli.debug',
        type    => 'boolean',
        require => File[$facter_conf_path],
      }
    }

    if $cli_trace != undef {
      hocon_setting { 'facter_conf.cli.trace':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'cli.trace',
        type    => 'boolean',
        value   => $cli_trace,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.cli.trace':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'cli.trace',
        type    => 'boolean',
        require => File[$facter_conf_path],
      }
    }

    if $cli_verbose != undef {
      hocon_setting { 'facter_conf.cli.verbose':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'cli.verbose',
        type    => 'boolean',
        value   => $cli_verbose,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.cli.verbose':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'cli.verbose',
        type    => 'boolean',
        require => File[$facter_conf_path],
      }
    }

    if $cli_log_level != undef {
      hocon_setting { 'facter_conf.cli.log-level':
        ensure  => present,
        path    => $facter_conf_path,
        setting => 'cli.log-level',
        type    => 'string',
        value   => $cli_log_level,
        require => File[$facter_conf_path],
      }
    } else {
      hocon_setting { 'facter_conf.cli.log-level':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'cli.log-level',
        type    => 'string',
        require => File[$facter_conf_path],
      }
    }

    if $fact_groups != undef {
      $fact_groups.each | Struct[{ name => String[1], facts => Array[String[1]], }] $fact_group | {
        hocon_setting { "facter_conf.fact-groups.${fact_group['name']}":
          ensure  => present,
          path    => $facter_conf_path,
          setting => "fact-groups.${fact_group['name']}",
          type    => 'array',
          value   => $fact_group['facts'],
          require => File[$facter_conf_path],
        }
      }
    } else {
      hocon_setting { 'facter_conf.fact-groups':
        ensure  => absent,
        path    => $facter_conf_path,
        setting => 'fact-groups',
        type    => 'hash',
        require => File[$facter_conf_path],
      }
    }
  }
}
