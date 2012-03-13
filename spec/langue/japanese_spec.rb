require 'langue/japanese'

describe Langue::Japanese do
  it 'has VERSION constant' do
    described_class.should be_const_defined :VERSION
  end
end
