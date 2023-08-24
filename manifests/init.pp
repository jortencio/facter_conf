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
  String $config_path,
) {
}
