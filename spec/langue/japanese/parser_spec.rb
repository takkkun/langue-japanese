require 'langue/japanese/parser'

def make_node(surface, next_node = nil)
  stub.tap do |s|
    s.stub!(:surface).and_return(surface.to_s)
    s.stub!(:feature).and_return('part_of_speech,category1,*,*,*,*,*,*')
    s.stub!(:next).and_return(next_node)
  end
end

def make_node_list(n)
  node = make_node('')

  n.times do |i|
    node = make_node(n - i, node)
  end

  make_node('', node)
end

describe Langue::Japanese::Parser, '#mecab_options' do
  it 'returns the value of the options gave to the constructor' do
    parser = described_class.new(:mecab_options => {:key => 'value'})
    mecab_options = parser.mecab_options
    mecab_options.should == {:key => 'value'}
  end

  context 'with no mecab_options option' do
    it 'returns an empty hash' do
      parser = described_class.new
      mecab_options = parser.mecab_options
      mecab_options.should == {}
    end
  end
end

describe Langue::Japanese::Parser, '#parse' do
  before do
    node = make_node_list(3)
    tagger = stub.tap {|s| s.stub!(:parseToNode).with('text').and_return(node)}
    parser = described_class.new.tap {|s| s.stub!(:tagger).and_return(tagger)}
    @morphemes = parser.parse('text')
  end

  it 'returns an instance of Langue::Morphemes' do
    @morphemes.should be_a Langue::Morphemes
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
    c = described_class

    @caller = lambda do |block = nil|
      parser = c.new
      block[parser] if block
      parser.instance_eval { tagger }
    end
  end

  it 'returns an instance of MeCab::Tagger' do
    MeCab::Tagger.stub!(:new).and_return('tagger')
    @caller[].should == 'tagger'
  end

  it 'passes the options of MeCab to the MeCab::Tagger.new' do
    MeCab::Tagger.should_receive(:new).with('mecab_options')
    @caller[lambda {|parser| parser.stub!(:mecab_options_as_string).and_return('mecab_options')}]
  end
end

describe Langue::Japanese::Parser, '#mecab_options_as_string' do
  before do
    c = described_class

    @caller = lambda do |options = {}, all_options = {}|
      parser = c.new(all_options.merge(:mecab_options => options))
      parser.instance_eval { mecab_options_as_string }
    end
  end

  it 'returns a string included d option if it gives sysdic option' do
    @caller[:sysdic => 'sysdic'].should == '-d sysdic'
  end

  it 'returns a string included u option if it gives userdic option' do
    @caller[:userdic => 'userdic'].should == '-u userdic'
  end

  it 'returns an empty string if it does not give options' do
    @caller[].should == ''
  end

  context 'with a unsupported option' do
    it 'logs that an option is unsupported' do
      logger = mock.tap do |m|
        map = {
          :level   => 'warn',
          :message => "'unsupported' option is unsupported",
          :key     => :unsupported
        }

        m.should_receive(:post).with('langue.japanese.parser', map)
      end

      @caller[{:unsupported => 'value'}, :logger => logger]
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

  it 'replaces an empty value from the asterisk' do
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
