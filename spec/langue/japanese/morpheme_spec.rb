require 'langue/japanese/morpheme'

describe Langue::Japanese::Morpheme, '.from_mecab_node' do
  it 'returns an expected morpheme' do
    surface = 'surface'
    feature = 'part_of_speech,category1,category2,category3,inflection,inflection_type,root_form,yomi,pronunciation'
    morpheme = described_class.from_mecab_node(surface, feature)
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
    morpheme = described_class.from_mecab_node(surface, feature)
    morpheme.part_of_speech.should be_nil
    morpheme.categories.should be_empty
    morpheme.inflection.should be_nil
    morpheme.inflection_type.should be_nil
    morpheme.root_form.should be_nil
    morpheme.yomi.should be_nil
    morpheme.pronunciation.should be_nil
  end
end

describe Langue::Japanese::Morpheme, '#classified?' do
  before do
    @morpheme = described_class.new(
      :part_of_speech => 'part_of_speech',
      :categories     => %w(category1 category2)
    )
  end

  context 'with only a part of speech' do
    it 'returns true if match' do
      @morpheme.should be_classified('part_of_speech')
    end

    it 'returns false if unmatch' do
      @morpheme.should_not be_classified('other_part_of_speech')
    end
  end

  context 'with categories less than number of categories' do
    it 'returns true if match' do
      @morpheme.should be_classified('part_of_speech', 'category1')
    end

    it 'returns false if unmatch' do
      @morpheme.should_not be_classified('part_of_speech', 'other_category1')
    end
  end

  context 'with categories equal to number of categories' do
    it 'returns true if match' do
      @morpheme.should be_classified('part_of_speech', 'category1', 'category2')
    end

    it 'returns false if unmatch' do
      @morpheme.should_not be_classified('part_of_speech', 'category1', 'other_category2')
    end
  end

  context 'with categories more than number of categories' do
    it 'returns false' do
      @morpheme.should_not be_classified('part_of_speech', 'category1', 'category2', 'category3')
    end
  end
end

describe Langue::Japanese::Morpheme, '#inflected?' do
  before do
    @morpheme = described_class.new(:inflection => 'inflection')
  end

  it 'returns true if match' do
    @morpheme.should be_inflected 'inflection'
  end

  it 'returns false if unmatch' do
    @morpheme.should_not be_inflected 'other_inflection'
  end
end
