# frozen_string_literal: true

require 'spec_helper'

describe 'facter_conf' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      facter_path = if os_facts[:os]['family'] == 'windows'
                      'C:/ProgramData/PuppetLabs/facter/etc'
                    else
                      '/etc/puppetlabs/facter'
                    end

      context 'has default parameters set' do
        it { is_expected.to contain_file(facter_path).with_ensure('directory') }
        it { is_expected.to contain_file("#{facter_path}/facter.conf").with_ensure('file') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.debug').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.log-level').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.trace').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.verbose').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.fact-groups').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.facts.blocklist').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.facts.ttls').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.custom-dir').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.external-dir').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.no-custom-facts').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.no-external-facts').with_ensure('absent') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.no-ruby').with_ensure('absent') }

        it { is_expected.to compile.with_all_deps }
      end

      context 'has example parameters set' do
        let(:params) do
          {
            facts_blocklist: ['file system', 'EC2', 'os.architecture'],
            facts_ttls: [
              { 'timezone': '30 days' },
            ],
            global_external_dir: ['path1', 'path2'],
            global_custom_dir: ['custom/path'],
            global_no_external_facts: false,
            global_no_custom_facts: false,
            global_no_ruby: false,
            cli_debug: false,
            cli_trace: true,
            cli_verbose: false,
            cli_log_level: 'warn',
            fact_groups: [
              {
                name: 'custom-group-name',
                facts: ['os.name', 'ssh'],
              },
            ],
          }
        end

        it { is_expected.to contain_file(facter_path).with_ensure('directory') }
        it { is_expected.to contain_file("#{facter_path}/facter.conf").with_ensure('file') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.debug').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.log-level').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.trace').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.cli.verbose').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.fact-groups.custom-group-name').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.facts.blocklist').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.facts.ttls').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.custom-dir').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.external-dir').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.no-custom-facts').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.no-external-facts').with_ensure('present') }
        it { is_expected.to contain_hocon_setting('facter_conf.global.no-ruby').with_ensure('present') }

        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
