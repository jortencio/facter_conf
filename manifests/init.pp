# @summary A class for configuring facter.conf
#
# Configures facter.conf based on settings available at https://www.puppet.com/docs/puppet/latest/configuring_facter.html
#
# @param config_path
#
#  Path for configuring facter.conf
#
# @example
#   include facter_conf
class facter_conf (
  Boolean                    $manage_facter_conf = true,
  String                     $config_path = '/etc/puppetlabs/facter/facter.conf',
  Optional[Array[String[1]]] $facts_blocklist = undef,
  Optional[Array[Hash]]      $facts_ttls = undef,
  Optional[Array[String[1]]] $global_external_dir = undef,
  Optional[Array[String[1]]] $global_custom_dir = undef,
  Optional[Boolean]          $global_no_external = undef,
  Optional[Boolean]          $global_no_custom = undef,
  Optional[Boolean]          $global_no_ruby = undef,
  Optional[Boolean]          $cli_debug = undef,
  Optional[Boolean]          $cli_trace = undef,
  Optional[Boolean]          $cli_verbose = undef,
  Optional[Enum[
      'none',
      'fatal',
      'error',
      'warn',
      'info',
      'debug',
      'trace'
  ]]                         $cli_log_level = undef,
  Optional[Hash]             $fact_groups = undef,
) {
  if $manage_facter_conf {
    file { "${config_path}/facter.conf":
      ensure  => file,
      content => epp('facter_conf/facter.conf.epp'),
    }
  }
}
