# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/facter_cached_facts'

describe :facter_cached_facts, type: :fact do
  subject(:fact) { Facter.fact(:facter_cached_facts) }

  before :each do
    Facter.clear
    allow(Facter.fact(:facter_conf_exists)).to receive(:value).and_return(true)
    allow(Facter.fact(:os)).to receive(:value).and_return({ 'family' => 'windows' })
    allow(Hocon).to receive(:load).with('C:/ProgramData/PuppetLabs/facter/etc/facter.conf').and_return({
                                                                                                         'facts' => {
                                                                                                           'ttls' => [
                                                                                                             { 'timezone' => '30 days' },
                                                                                                             { 'architecture' => '30 days' },
                                                                                                           ]
                                                                                                         }
                                                                                                       })
  end

  it 'returns a value' do
    expect(fact.value).to eq({
                               'timezone' => ['30 days'],
                               'architecture' => ['30 days'],
                             })
  end
end
