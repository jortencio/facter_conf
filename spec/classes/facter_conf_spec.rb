# frozen_string_literal: true

require 'spec_helper'

describe 'facter_conf' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      if os_facts[:os]['family'] == 'windows'
        facter_path = 'C:/ProgramData/PuppetLabs/facter/etc'
      else
        facter_path = '/etc/puppetlabs/facter'
      end

      it { is_expected.to contain_file(facter_path) }
      it { is_expected.to contain_file("#{facter_path}/facter.conf") }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
