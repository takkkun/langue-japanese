require 'langue/japanese'

describe Langue::Japanese do
  it 'is an instance of Class' do
    described_class.should be_an_instance_of Class
  end

  it 'include Langue::Language' do
    described_class.should be_include Langue::Language
  end

  it 'has VERSION constant' do
    described_class.should be_const_defined :VERSION
  end
end

describe Langue::Japanese, '#parse' do
  before :all do
    require 'langue/japanese/parser'
  end

  before do
    @parser = stub.tap {|s| s.stub!(:parse).and_return('morphemes')}
    Langue::Japanese::Parser.stub!(:new).and_return(@parser)
  end

  before do
    @language = described_class.new(:key => 'value')
  end

  it 'returns an instance of Langue::Morphemes' do
    morphemes = @language.parse('text')
    morphemes.should == 'morphemes'
  end

  it 'passes the options to Langue::Japanese::Parser.new' do
    Langue::Japanese::Parser.should_receive(:new).with(:key => 'value').and_return(@parser)
    @language.parse('text')
  end

  it 'passes the text to Langue::Japanese::Parser#parse' do
    @parser.should_receive(:parse).with('text').and_return('morphemes')
    @language.parse('text')
  end
end

describe Langue::Japanese, '#structuralize' do
  it 'returns an instance of Langue::Text'
end
