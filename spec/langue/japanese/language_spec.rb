require 'spec_helper'
require 'langue/japanese/language'

describe Langue::Japanese::Language do
  it 'is an instance of Class' do
    described_class.should be_an_instance_of(Class)
  end

  it 'extends Langue::Language' do
    described_class.superclass.should == Langue::Language
  end
end

describe Langue::Japanese::Language, '#parser' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls Langue::Japanese::Parser.new with the options' do
    parser_stub
    Langue::Japanese::Parser.should_receive(:new).with(:key => 'value')
    @language.parser
  end

  it 'returns an instance of Langue::Japanese::Parser' do
    parser = parser_stub
    @language.parser.should == parser
  end
end

describe Langue::Japanese::Language, '#structurer' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls Langue::Japanese::Structurer.new with the options' do
    structurer_stub
    Langue::Japanese::Structurer.should_receive(:new).with(:key => 'value')
    @language.structurer
  end

  it 'returns an instance of Langue::Japanese::Structurer' do
    structurer = structurer_stub
    @language.structurer.should == structurer
  end
end

describe Langue::Japanese::Language, '#parse' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls parse method of parser with a text' do
    parser_stub do |m|
      m.should_receive(:parse).with('text')
    end

    @language.parse('text')
  end

  it 'returns the value returning from Langue::Japanese::Parser#parse' do
    parser_stub
    @language.parse('text').should == 'value returning from parse method'
  end
end

describe Langue::Japanese::Language, '#structure' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls structure method of structurer with morphemes' do
    structurer_stub do |m|
      m.should_receive(:structure).with('morphemes')
    end

    @language.structure('morphemes')
  end

  it 'returns the value returning from Langue::Japanese::Structurer#structure' do
    structurer_stub
    @language.structure('morphemes').should == 'value returning from structure method'
  end
end
