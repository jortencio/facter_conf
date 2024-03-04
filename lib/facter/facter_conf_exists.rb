# frozen_string_literal: true

Facter.add(:facter_conf_exists) do
  setcode do
    facter_conf_path = if Facter.value('os')['family'] == 'windows'
                         'C:/ProgramData/PuppetLabs/facter/etc/facter.conf'
                       else
                         '/etc/puppetlabs/facter/facter.conf'
                       end
    File.exist? facter_conf_path
  end
end
