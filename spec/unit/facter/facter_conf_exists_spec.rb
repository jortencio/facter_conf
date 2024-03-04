# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/facter_conf_exists'

describe :facter_conf_exists, type: :fact do
  subject(:fact) { Facter.fact(:facter_conf_exists) }

  before :each do
    Facter.clear
    allow(Facter.fact(:os)).to receive(:value).and_return({ 'family' => 'windows' })
    allow(File).to receive(:exist?).with('C:/ProgramData/PuppetLabs/facter/etc/facter.conf').and_return(true)
  end

  it 'returns a value' do
    expect(fact.value).to eq(true)
  end
end
