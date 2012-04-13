require 'spec_helper'
require 'langue/japanese/parser'

describe Langue::Japanese::Parser, '#initialize' do
  it 'sets an empty hash to mecab_options attribute' do
    parser = described_class.new
    mecab_options = parser.mecab_options
    mecab_options.should be_a(Hash)
    mecab_options.should be_empty
  end

  it 'sets an instance of Langue::Japanese::Logging::NullLogger to @logger' do
    parser = described_class.new
    logger = parser.instance_eval { @logger }
    logger.should be_a(Langue::Japanese::Logging::NullLogger)
  end

  it 'sets an empty hash to @taggers' do
    parser = described_class.new
    taggers = parser.instance_eval { @taggers }
    taggers.should be_a(Hash)
    taggers.should be_empty
  end

  context 'with mecab_options option' do
    it 'sets the value of mecab_options option to mecab_options attribute' do
      parser = described_class.new(:mecab_options => {:key => 'value'})
      parser.mecab_options.should == {:key => 'value'}
    end
  end

  context 'with logger option' do
    it 'sets the value of logger option to @logger' do
      parser = described_class.new(:logger => 'logger')
      logger = parser.instance_eval { @logger }
      logger.should == 'logger'
    end
  end
end

describe Langue::Japanese::Parser, '#parse' do
  before do
    tagger_stub(3)
    @morphemes = described_class.new.parse('text')
  end

  it 'returns an instance of Langue::Morphemes' do
    @morphemes.should be_a(Langue::Morphemes)
  end

  it 'returns an array with the number of morpheme' do
    @morphemes.should have(3).items
  end

  it 'returns an array containing the contents of the morpheme' do
    @morphemes[0].text.should == '1'
    @morphemes[1].text.should == '2'
    @morphemes[2].text.should == '3'
  end
end

describe Langue::Japanese::Parser, '#tagger' do
  before do
    @parser = described_class.new
  end

  it 'calls MeCab::Tagger.new with mecab_options attribute' do
    MeCab::Tagger.should_receive(:new).with('mecab_options')
    @parser.stub!(:mecab_options_as_string).and_return('mecab_options')
    @parser.send(:tagger)
  end

  it 'returns an instance of MeCab::Tagger' do
    tagger = tagger_stub
    @parser.send(:tagger).should == tagger
  end
end

describe Langue::Japanese::Parser, '#mecab_options_as_string' do
  it 'returns an empty string if it does not give options' do
    parser = described_class.new
    mecab_options_as_string = parser.send(:mecab_options_as_string)
    mecab_options_as_string.should be_a(String)
    mecab_options_as_string.should be_empty
  end

  context 'with sysdic option' do
    it 'returns a string included d option' do
      parser = described_class.new(:mecab_options => {:sysdic => 'sysdic'})
      parser.send(:mecab_options_as_string).should == '-d sysdic'
    end
  end

  context 'with userdic option' do
    it 'returns a string included u option' do
      parser = described_class.new(:mecab_options => {:userdic => 'userdic'})
      parser.send(:mecab_options_as_string).should == '-u userdic'
    end
  end

  context 'with an unsupported option' do
    it 'logs that an option is unsupported' do
      parser = described_class.new(:mecab_options => {:unsupported => 'value'})

      parser.instance_eval { @logger }.should_receive(:post).with('langue.japanese.parser', {
        :level   => 'warn',
        :message => "'unsupported' option is unsupported",
        :key     => :unsupported
      })

      parser.send(:mecab_options_as_string)
    end
  end
end

describe Langue::Japanese::Parser, '#create_morpheme' do
  before do
    @parser = described_class.new
  end

  it 'returns an expected morpheme' do
    surface = 'surface'
    feature = 'part_of_speech,category1,category2,category3,inflection,inflection_type,root_form,yomi,pronunciation'
    morpheme = @parser.send(:create_morpheme, surface, feature)
    morpheme.text.should == 'surface'
    morpheme.part_of_speech.should == 'part_of_speech'
    morpheme.categories.should == %w(category1 category2 category3)
    morpheme.inflection.should == 'inflection'
    morpheme.inflection_type.should == 'inflection_type'
    morpheme.root_form.should == 'root_form'
    morpheme.yomi.should == 'yomi'
    morpheme.pronunciation.should == 'pronunciation'
  end

  it 'replaces to nil from the asterisk' do
    surface = 'surface'
    feature = '*,*,*,*,*,*,*,*,*'
    morpheme = @parser.send(:create_morpheme, surface, feature)
    morpheme.part_of_speech.should be_nil
    morpheme.categories.should be_empty
    morpheme.inflection.should be_nil
    morpheme.inflection_type.should be_nil
    morpheme.root_form.should be_nil
    morpheme.yomi.should be_nil
    morpheme.pronunciation.should be_nil
  end
end
