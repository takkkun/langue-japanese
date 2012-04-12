require 'langue/japanese/language'

describe Langue::Japanese::Language do
  it 'is an instance of Class' do
    described_class.should be_an_instance_of(Class)
  end

  it 'extends Langue::Language' do
    described_class.superclass.should == Langue::Language
  end
end

describe Langue::Japanese::Language, '#parse' do
  before :all do
    require 'langue/japanese/parser'
  end

  before do
    @parser = stub.tap { |s| s.stub!(:parse).and_return('morphemes') }
    Langue::Japanese::Parser.stub!(:new).and_return(@parser)
  end

  before do
    @language = described_class.new(:key => 'value')
  end

  it "returns the value returning from #{described_class}::Parser#parse" do
    morphemes = @language.parse('text')
    morphemes.should == 'morphemes'
  end

  it "passes the options to #{described_class}::Parser.new" do
    Langue::Japanese::Parser.should_receive(:new).with(:key => 'value').and_return(@parser)
    @language.parse('text')
  end

  it "passes the text to #{described_class}::Parser#parse" do
    @parser.should_receive(:parse).with('text').and_return('morphemes')
    @language.parse('text')
  end
end

describe Langue::Japanese::Language, '#structure' do
  before :all do
    require 'langue/japanese/structurer'
  end

  before do
    @structurer = stub.tap { |s| s.stub!(:structure).and_return('text') }
    Langue::Japanese::Structurer.stub!(:new).and_return(@structurer)
  end

  before do
    @language = described_class.new(:key => 'value')
  end

  it "returns the value returning from #{described_class}::Structurer#structure" do
    text = @language.structure('morphemes')
    text.should == 'text'
  end

  it "passes the options to #{described_class}::Structurer.new" do
    Langue::Japanese::Structurer.should_receive(:new).with(:key => 'value').and_return(@structurer)
    @language.structure('morphemes')
  end

  it "passes the morphemes to #{described_class}::Structurer#structure" do
    @structurer.should_receive(:structure).with('morphemes').and_return('text')
    @language.structure('morphemes')
  end
end
