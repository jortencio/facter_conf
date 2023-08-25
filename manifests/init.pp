# @summary A class for configuring facter.conf
#
# Configures facter.conf based on settings available at https://www.puppet.com/docs/puppet/latest/configuring_facter.html
#
# @param facter_conf_ensure
# @param config_path
#
#  Path for configuring facter.conf
#
# @param owner
# @param group
# @param mode
# @param facts_blocklist
# @param facts_ttls
# @param global_external_dir
# @param global_custom_dir
# @param global_no_external_facts
# @param global_no_custom_facts
# @param global_no_ruby
# @param cli_debug
# @param cli_trace
# @param cli_verbose
# @param cli_log_level
# @param fact_groups
#
# @example
#   include facter_conf
class facter_conf (
  Enum[present,absent]       $facter_conf_ensure = present,
  String[1]                  $config_path = '/etc/puppetlabs/facter/facter.conf',
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

  if $facter_conf_ensure == present {
    if $facts_blocklist {
      hocon_setting { 'facter_conf.facts.blocklist':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'facts.blocklist',
        type    => 'array',
        value   => $facts_blocklist,
        require => File[$facter_conf_path],
      }
    }

    if $facts_ttls {
      hocon_setting { 'facter_conf.facts.ttls':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'facts.ttls',
        type    => 'array',
        value   => $facts_ttls,
        require => File[$facter_conf_path],
      }
    }

    if $global_external_dir {
      hocon_setting { 'facter_conf.global.external-dir':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'global.external-dir',
        type    => 'array',
        value   => $global_external_dir,
        require => File[$facter_conf_path],
      }
    }

    if $global_custom_dir {
      hocon_setting { 'facter_conf.global.custom-dir':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'global.custom-dir',
        type    => 'array',
        value   => $facts_ttls,
        require => File[$facter_conf_path],
      }
    }

    if $global_no_external_facts {
      hocon_setting { 'facter_conf.global.no-external-facts':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'global.no-external-facts',
        type    => 'boolean',
        value   => $global_no_external_facts,
        require => File[$facter_conf_path],
      }
    }

    if $global_no_custom_facts {
      hocon_setting { 'facter_conf.global.no-custom-facts':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'global.no-custom-facts',
        type    => 'boolean',
        value   => $global_no_custom_facts,
        require => File[$facter_conf_path],
      }
    }

    if $global_no_ruby {
      hocon_setting { 'facter_conf.global.no-ruby':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'global.no-ruby',
        type    => 'boolean',
        value   => $global_no_ruby,
        require => File[$facter_conf_path],
      }
    }

    if $cli_debug {
      hocon_setting { 'facter_conf.cli.debug':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'cli.debug',
        type    => 'boolean',
        value   => $cli_debug,
        require => File[$facter_conf_path],
      }
    }

    if $cli_trace {
      hocon_setting { 'facter_conf.cli.trace':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'cli.trace',
        type    => 'boolean',
        value   => $cli_trace,
        require => File[$facter_conf_path],
      }
    }

    if $cli_verbose {
      hocon_setting { 'facter_conf.cli.verbose':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'cli.verbose',
        type    => 'boolean',
        value   => $cli_verbose,
        require => File[$facter_conf_path],
      }
    }

    if $cli_log_level {
      hocon_setting { 'facter_conf.cli.log-level':
        ensure  => $facter_conf_ensure,
        path    => $facter_conf_path,
        setting => 'cli.log-level',
        type    => 'string',
        value   => $cli_log_level,
        require => File[$facter_conf_path],
      }
    }

    if $fact_groups {
      $fact_groups.each | Array $fact_group | {
        hocon_setting { "facter_conf.fact-groups.${fact_group['name']}":
          ensure  => $facter_conf_ensure,
          path    => $facter_conf_path,
          setting => "fact-groups.${fact_group['name']}",
          type    => 'array',
          value   => $fact_group['facts'],
          require => File[$facter_conf_path],
        }
      }
    }
  }
}
