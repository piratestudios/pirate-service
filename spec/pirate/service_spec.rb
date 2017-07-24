require 'spec_helper'

describe Pirate::Service do
  it 'has a version number' do
    expect(Pirate::Service::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
