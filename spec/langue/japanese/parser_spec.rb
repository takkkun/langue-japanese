require 'spec_helper'
require 'langue/japanese/parser'

describe Langue::Japanese::Parser, '#initialize' do
  it 'sets an empty hash to tagger_options attribute by default' do
    parser = described_class.new
    tagger_options = parser.tagger_options
    tagger_options.should be_a(Hash)
    tagger_options.should be_empty
  end

  it 'sets an instance of Langue::Japanese::Logging::NullLogger to @logger by default' do
    parser = described_class.new
    logger = parser.instance_eval { @logger }
    logger.should be_a(Langue::Japanese::Logging::NullLogger)
  end

  it 'sets an empty hash to @taggers by default' do
    parser = described_class.new
    taggers = parser.instance_eval { @taggers }
    taggers.should be_a(Hash)
    taggers.should be_empty
  end

  context 'with tagger_options option' do
    it 'sets the value of tagger_options option to tagger_options attribute' do
      parser = described_class.new(:tagger_options => {:key => 'value'})
      parser.tagger_options.should == {:key => 'value'}
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
    parser = described_class.new
    parser.stub!(:tagger).and_return(parser_tagger_stub(3))
    @morphemes = parser.parse('text')
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

  def set_version(version)
    old_version = MeCab::VERSION

    MeCab.module_eval do
      remove_const(:VERSION)
      const_set(:VERSION, version)
    end

    return old_version unless block_given?

    begin
      yield
    ensure
      set_version(old_version)
    end
  end

  it 'returns an instance of MeCab::Tagger' do
    tagger = @parser.send(:tagger)
    tagger.should be_a(MeCab::Tagger)
  end

  it "calls tagger_with with tagger_options attribute if MeCab's version is 0.98" do
    set_version('0.98') do
      @parser.should_receive(:tagger_with).with('tagger_options')
      @parser.stub!(:tagger_options_as_string).and_return('tagger_options')
      @parser.send(:tagger)
    end
  end

  it "calls tagger_by_model_with with tagger_options attribute if MeCab's version is 0.99 later" do
    set_version('0.99') do
      @parser.should_receive(:tagger_by_model_with).with('tagger_options')
      @parser.stub!(:tagger_options_as_string).and_return('tagger_options')
      @parser.send(:tagger)
    end
  end
end

describe Langue::Japanese::Parser, '#tagger_with' do
  before do
    @parser = described_class.new
  end

  it 'calls MeCab::Tagger.new with tagger_options attribute' do
    MeCab::Tagger.should_receive(:new).with('tagger_options').and_return(parser_tagger_stub)
    @parser.send(:tagger_with, 'tagger_options')
  end

  it 'returns an instance of MeCab::Tagger' do
    tagger_stub = parser_tagger_stub
    tagger = @parser.send(:tagger_with, 'tagger_options')
    tagger.should == tagger_stub
  end
end

describe Langue::Japanese::Parser, '#tagger_by_model_with' do
  before do
    @parser = described_class.new
    @parser.instance_eval { @@models = {} }
  end

  it 'calls MeCab::Model.create with mecab_options attribute' do
    MeCab::Model.should_receive(:create).with('tagger_options').and_return(parser_model_stub)
    @parser.send(:tagger_by_model_with, 'tagger_options')
  end

  it 'calls MeCab::Model#createTagger' do
    parser_model_stub do |m|
      m.should_receive(:createTagger)
    end

    @parser.send(:tagger_by_model_with, 'tagger_options')
  end

  it 'returns an instance of MeCab::Tagger' do
    tagger_stub = parser_tagger_stub
    parser_model_stub(tagger_stub)
    tagger = @parser.send(:tagger_by_model_with, 'tagger_options')
    tagger.should == tagger_stub
  end
end

describe Langue::Japanese::Parser, '#tagger_options_as_string' do
  it 'returns an empty string if it does not give options' do
    parser = described_class.new
    tagger_options = parser.send(:tagger_options_as_string)
    tagger_options.should be_a(String)
    tagger_options.should be_empty
  end

  context 'with sysdic option' do
    it 'returns a string included d option' do
      parser = described_class.new(:tagger_options => {:sysdic => 'sysdic'})
      parser.send(:tagger_options_as_string).should == '-d sysdic'
    end
  end

  context 'with userdic option' do
    it 'returns a string included u option' do
      parser = described_class.new(:tagger_options => {:userdic => 'userdic'})
      parser.send(:tagger_options_as_string).should == '-u userdic'
    end
  end

  context 'with an unsupported option' do
    it 'logs that an option is unsupported' do
      parser = described_class.new(:tagger_options => {:unsupported => 'value'})

      parser.instance_eval { @logger }.should_receive(:post).with('langue.japanese.parser', {
        :level   => 'warn',
        :message => "'unsupported' option is unsupported",
        :key     => :unsupported
      })

      parser.send(:tagger_options_as_string)
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
