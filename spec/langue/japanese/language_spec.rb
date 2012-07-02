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

describe Langue::Japanese::Language, '#shaper' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls Langue::Japanese::Shaper.new with the options' do
    shaper_stub
    Langue::Japanese::Shaper.should_receive(:new).with(:key => 'value')
    @language.shaper
  end

  it 'returns an instance of Langue::Japanese::Shaper' do
    shaper = shaper_stub
    @language.shaper.should == shaper
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

describe Langue::Japanese::Language, '#inflector' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls Langue::Japanese::Inflector.new with the options' do
    inflector_stub
    Langue::Japanese::Inflector.should_receive(:new).with(:key => 'value')
    @language.inflector
  end

  it 'returns an instance of Langue::Japanese::Inflector' do
    inflector = inflector_stub
    @language.inflector.should == inflector
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

describe Langue::Japanese::Language, '#shape_person_name' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls shape_person_name method of shaper with morphemes' do
    shaper_stub do |m|
      m.should_receive(:shape_person_name).with('morphemes', 'Akane')
    end

    @language.shape_person_name('morphemes', 'Akane')
  end

  it 'returns the value returning from Langue::Japanese::Shaper#shape_person_name' do
    shaper_stub
    @language.shape_person_name('morphemes', 'Akane').should == 'value returning from shape_person_name method'
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

describe Langue::Japanese::Language, '#inflect' do
  before do
    @language = described_class.new(:key => 'value')
  end

  it 'calls #inflect of the inflector with the inflectional classification, the word, the inflectional form and the options' do
    inflector_stub do |m|
      m.should_receive(:inflect).with('classification', 'word', 'form', :key => 'value')
    end

    @language.inflect('classification', 'word', 'form', :key => 'value')
  end

  it 'returns the value returning from Langue::Japanese::Inflector#inflect' do
    inflector_stub
    @language.inflect('classification', 'word', 'form', :key => 'value').should == 'value returning from #inflect'
  end
end
