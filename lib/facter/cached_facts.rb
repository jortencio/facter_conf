# frozen_string_literal: true

require 'hocon'

Facter.add(:cached_facts) do
  confine facter_conf_exists: true
  setcode do
    facter_conf_path = if Facter.value('os')['family'] == 'windows'
                         'C:/ProgramData/PuppetLabs/facter/etc/facter.conf'
                       else
                         '/etc/puppetlabs/facter/facter.conf'
                       end
    facter_conf = Hocon.load(facter_conf_path)

    if !facter_conf['facts']['ttls'].nil?
      facter_conf['facts']['ttls'].each_with_object({}) { |pairs, h| pairs.each { |k, v| (h[k] ||= []) << v } }
    else
      []
    end
  end
end
