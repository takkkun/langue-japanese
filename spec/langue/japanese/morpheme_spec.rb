# -*- coding: utf-8 -*-
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

describe Langue::Japanese::Morpheme, '#is_noun' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 名詞' do
    morpheme = described_class.new(:part_of_speech => '名詞')
    morpheme.is_noun.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 名詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_noun.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_prefix' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 接頭詞' do
    morpheme = described_class.new(:part_of_speech => '接頭詞')
    morpheme.is_prefix.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 接頭詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_prefix.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_adjective' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 形容詞' do
    morpheme = described_class.new(:part_of_speech => '形容詞')
    morpheme.is_adjective.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 形容詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_adjective.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_verb' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 動詞' do
    morpheme = described_class.new(:part_of_speech => '動詞')
    morpheme.is_verb.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 動詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_verb.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_adverb' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 副詞' do
    morpheme = described_class.new(:part_of_speech => '副詞')
    morpheme.is_adverb.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 副詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_adverb.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_particle' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 助詞' do
    morpheme = described_class.new(:part_of_speech => '助詞')
    morpheme.is_particle.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 助詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_particle.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_auxiliary_verb' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 助動詞' do
    morpheme = described_class.new(:part_of_speech => '助動詞')
    morpheme.is_auxiliary_verb.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 助動詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_auxiliary_verb.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_conjunction' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 接続詞' do
    morpheme = described_class.new(:part_of_speech => '接続詞')
    morpheme.is_conjunction.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 助動詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_conjunction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_determiner' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 連体詞' do
    morpheme = described_class.new(:part_of_speech => '連体詞')
    morpheme.is_determiner.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 連体詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_determiner.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_interjection' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 感動詞' do
    morpheme = described_class.new(:part_of_speech => '感動詞')
    morpheme.is_interjection.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 感動詞' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_interjection.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_symbol' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is 記号' do
    morpheme = described_class.new(:part_of_speech => '記号')
    morpheme.is_symbol.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not 記号' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_symbol.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_filler' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is フィラー' do
    morpheme = described_class.new(:part_of_speech => 'フィラー')
    morpheme.is_filler.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not フィラー' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_filler.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme, '#is_other' do
  it 'returns an instance of Langue::Japanese::Morpheme::Yes if part_of_speech is その他' do
    morpheme = described_class.new(:part_of_speech => 'その他')
    morpheme.is_other.should be_a Langue::Japanese::Morpheme::Yes
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if part_of_speech is not その他' do
    morpheme = described_class.new(:part_of_speech => 'part_of_speech')
    morpheme.is_other.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes do
  it 'extends Langue::Japanese::Morpheme::Opinion' do
    described_class.superclass.should == Langue::Japanese::Morpheme::Opinion
  end

  it 'is so' do
    described_class.new([]).should be_so
  end
end

describe Langue::Japanese::Morpheme::Yes, '#next' do
  before do
    opinion = described_class.new(%w(category1 category2))
    @next_opinion = opinion.next('category1')
  end

  it "returns an instance of #{described_class}" do
    @next_opinion.should be_a described_class
  end

  it 'forwards the pointer of the categories' do
    categories = @next_opinion.instance_variable_get(:@categories)
    categories.should == %w(category2)
  end

  context 'with an unmatched category' do
    before do
      opinion = described_class.new(%w(category1 category2))
      @next_opinion = opinion.next('category2')
    end

    it 'returns an instance of Langue::Japanese::Morpheme::No' do
      @next_opinion.should be_a Langue::Japanese::Morpheme::No
    end
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_general' do
  it "returns an instance of #{described_class} if category is 一般" do
    opinion = described_class.new(%w(一般))
    opinion.and_general.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 一般' do
    opinion = described_class.new(%w(category))
    opinion.and_general.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_special' do
  it "returns an instance of #{described_class} if category is 特殊" do
    opinion = described_class.new(%w(特殊))
    opinion.and_special.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 特殊' do
    opinion = described_class.new(%w(category))
    opinion.and_special.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_proper' do
  it "returns an instance of #{described_class} if category is 固有名詞" do
    opinion = described_class.new(%w(固有名詞))
    opinion.and_proper.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 固有名詞' do
    opinion = described_class.new(%w(category))
    opinion.and_proper.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_person' do
  it "returns an instance of #{described_class} if category is 人名" do
    opinion = described_class.new(%w(人名))
    opinion.and_person.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 人名' do
    opinion = described_class.new(%w(category))
    opinion.and_person.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_surname' do
  it "returns an instance of #{described_class} if category is 姓" do
    opinion = described_class.new(%w(姓))
    opinion.and_surname.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 姓' do
    opinion = described_class.new(%w(category))
    opinion.and_surname.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_forename' do
  it "returns an instance of #{described_class} if category is 名" do
    opinion = described_class.new(%w(名))
    opinion.and_forename.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 名' do
    opinion = described_class.new(%w(category))
    opinion.and_forename.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_organization' do
  it "returns an instance of #{described_class} if category is 組織" do
    opinion = described_class.new(%w(組織))
    opinion.and_organization.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 組織' do
    opinion = described_class.new(%w(category))
    opinion.and_organization.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_place' do
  it "returns an instance of #{described_class} if category is 地域" do
    opinion = described_class.new(%w(地域))
    opinion.and_place.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 地域' do
    opinion = described_class.new(%w(category))
    opinion.and_place.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_country' do
  it "returns an instance of #{described_class} if category is 国" do
    opinion = described_class.new(%w(国))
    opinion.and_country.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 国' do
    opinion = described_class.new(%w(category))
    opinion.and_country.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_quantity' do
  it "returns an instance of #{described_class} if category is 数" do
    opinion = described_class.new(%w(数))
    opinion.and_quantity.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 数' do
    opinion = described_class.new(%w(category))
    opinion.and_quantity.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_suffix' do
  it "returns an instance of #{described_class} if category is 接尾" do
    opinion = described_class.new(%w(接尾))
    opinion.and_suffix.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 接尾' do
    opinion = described_class.new(%w(category))
    opinion.and_suffix.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_quantifier' do
  it "returns an instance of #{described_class} if category is 助数詞" do
    opinion = described_class.new(%w(助数詞))
    opinion.and_quantifier.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 助数詞' do
    opinion = described_class.new(%w(category))
    opinion.and_quantifier.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_pronoun' do
  it "returns an instance of #{described_class} if category is 代名詞" do
    opinion = described_class.new(%w(代名詞))
    opinion.and_pronoun.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 代名詞' do
    opinion = described_class.new(%w(category))
    opinion.and_pronoun.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_adverbization' do
  it "returns an instance of #{described_class} if category is 副詞化" do
    opinion = described_class.new(%w(副詞化))
    opinion.and_adverbization.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 副詞化' do
    opinion = described_class.new(%w(category))
    opinion.and_adverbization.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_attributivization' do
  it "returns an instance of #{described_class} if category is 連体化" do
    opinion = described_class.new(%w(連体化))
    opinion.and_attributivization.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 連体化' do
    opinion = described_class.new(%w(category))
    opinion.and_attributivization.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_adverbable' do
  it "returns an instance of #{described_class} if category is 副詞可能" do
    opinion = described_class.new(%w(副詞可能))
    opinion.and_adverbable.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 副詞可能' do
    opinion = described_class.new(%w(category))
    opinion.and_adverbable.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_noun_conjunction' do
  it "returns an instance of #{described_class} if category is 名詞接続" do
    opinion = described_class.new(%w(名詞接続))
    opinion.and_noun_conjunction.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 名詞接続' do
    opinion = described_class.new(%w(category))
    opinion.and_noun_conjunction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_quantity_conjunction' do
  it "returns an instance of #{described_class} if category is 数接続" do
    opinion = described_class.new(%w(数接続))
    opinion.and_quantity_conjunction.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 数接続' do
    opinion = described_class.new(%w(category))
    opinion.and_quantity_conjunction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_suru_conjunction' do
  it "returns an instance of #{described_class} if category is サ変接続" do
    opinion = described_class.new(%w(サ変接続))
    opinion.and_suru_conjunction.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not サ変接続' do
    opinion = described_class.new(%w(category))
    opinion.and_suru_conjunction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_adjective_conjunction' do
  it "returns an instance of #{described_class} if category is 形容詞接続" do
    opinion = described_class.new(%w(形容詞接続))
    opinion.and_adjective_conjunction.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 形容詞接続' do
    opinion = described_class.new(%w(category))
    opinion.and_adjective_conjunction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_verb_conjunction' do
  it "returns an instance of #{described_class} if category is 動詞接続" do
    opinion = described_class.new(%w(動詞接続))
    opinion.and_verb_conjunction.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 動詞接続' do
    opinion = described_class.new(%w(category))
    opinion.and_verb_conjunction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_particle_conjunction' do
  it "returns an instance of #{described_class} if category is 助詞類接続" do
    opinion = described_class.new(%w(助詞類接続))
    opinion.and_particle_conjunction.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 助詞類接続' do
    opinion = described_class.new(%w(category))
    opinion.and_particle_conjunction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_adjective_verb_stem' do
  it "returns an instance of #{described_class} if category is 形容動詞語幹" do
    opinion = described_class.new(%w(形容動詞語幹))
    opinion.and_adjective_verb_stem.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 形容動詞語幹' do
    opinion = described_class.new(%w(category))
    opinion.and_adjective_verb_stem.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_auxiliary_verb_stem' do
  it "returns an instance of #{described_class} if category is 助動詞語幹" do
    opinion = described_class.new(%w(助動詞語幹))
    opinion.and_auxiliary_verb_stem.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 助動詞語幹' do
    opinion = described_class.new(%w(category))
    opinion.and_auxiliary_verb_stem.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_nai_adjective_stem' do
  it "returns an instance of #{described_class} if category is ナイ形容詞語幹" do
    opinion = described_class.new(%w(ナイ形容詞語幹))
    opinion.and_nai_adjective_stem.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not ナイ形容詞語幹' do
    opinion = described_class.new(%w(category))
    opinion.and_nai_adjective_stem.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_verb_noncategorematic_like' do
  it "returns an instance of #{described_class} if category is 動詞非自立的" do
    opinion = described_class.new(%w(動詞非自立的))
    opinion.and_verb_noncategorematic_like.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 動詞非自立的' do
    opinion = described_class.new(%w(category))
    opinion.and_verb_noncategorematic_like.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_conjunction_like' do
  it "returns an instance of #{described_class} if category is 接続詞的" do
    opinion = described_class.new(%w(接続詞的))
    opinion.and_conjunction_like.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 接続詞的' do
    opinion = described_class.new(%w(category))
    opinion.and_conjunction_like.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_interjection' do
  it "returns an instance of #{described_class} if category is 間投" do
    opinion = described_class.new(%w(間投))
    opinion.and_interjection.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 間投' do
    opinion = described_class.new(%w(category))
    opinion.and_interjection.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_contraction' do
  it "returns an instance of #{described_class} if category is 縮約" do
    opinion = described_class.new(%w(縮約))
    opinion.and_contraction.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 縮約' do
    opinion = described_class.new(%w(category))
    opinion.and_contraction.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_collocation' do
  it "returns an instance of #{described_class} if category is 連語" do
    opinion = described_class.new(%w(連語))
    opinion.and_collocation.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 連語' do
    opinion = described_class.new(%w(category))
    opinion.and_collocation.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_quotation' do
  it "returns an instance of #{described_class} if category is 引用" do
    opinion = described_class.new(%w(引用))
    opinion.and_quotation.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 引用' do
    opinion = described_class.new(%w(category))
    opinion.and_quotation.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_categorematic' do
  it "returns an instance of #{described_class} if category is 自立" do
    opinion = described_class.new(%w(自立))
    opinion.and_categorematic.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 自立' do
    opinion = described_class.new(%w(category))
    opinion.and_categorematic.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_noncategorematic' do
  it "returns an instance of #{described_class} if category is 非自立" do
    opinion = described_class.new(%w(非自立))
    opinion.and_noncategorematic.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 非自立' do
    opinion = described_class.new(%w(category))
    opinion.and_noncategorematic.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_nominative' do
  it "returns an instance of #{described_class} if category is 格助詞" do
    opinion = described_class.new(%w(格助詞))
    opinion.and_nominative.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 格助詞' do
    opinion = described_class.new(%w(category))
    opinion.and_nominative.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_binding' do
  it "returns an instance of #{described_class} if category is 係助詞" do
    opinion = described_class.new(%w(係助詞))
    opinion.and_binding.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 格助詞' do
    opinion = described_class.new(%w(category))
    opinion.and_binding.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_supplementary' do
  it "returns an instance of #{described_class} if category is 副助詞" do
    opinion = described_class.new(%w(副助詞))
    opinion.and_supplementary.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 副助詞' do
    opinion = described_class.new(%w(category))
    opinion.and_supplementary.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_conjunctive' do
  it "returns an instance of #{described_class} if category is 接続助詞" do
    opinion = described_class.new(%w(接続助詞))
    opinion.and_conjunctive.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 接続助詞' do
    opinion = described_class.new(%w(category))
    opinion.and_conjunctive.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_parallel' do
  it "returns an instance of #{described_class} if category is 並立助詞" do
    opinion = described_class.new(%w(並立助詞))
    opinion.and_parallel.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 並立助詞' do
    opinion = described_class.new(%w(category))
    opinion.and_parallel.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_final' do
  it "returns an instance of #{described_class} if category is 終助詞" do
    opinion = described_class.new(%w(終助詞))
    opinion.and_final.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 終助詞' do
    opinion = described_class.new(%w(category))
    opinion.and_final.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_ka' do
  it "returns an instance of #{described_class} if category is 副助詞／並立助詞／終助詞" do
    opinion = described_class.new(%w(副助詞／並立助詞／終助詞))
    opinion.and_ka.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 副助詞／並立助詞／終助詞' do
    opinion = described_class.new(%w(category))
    opinion.and_ka.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_alphabet' do
  it "returns an instance of #{described_class} if category is アルファベット" do
    opinion = described_class.new(%w(アルファベット))
    opinion.and_alphabet.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not アルファベット' do
    opinion = described_class.new(%w(category))
    opinion.and_alphabet.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_left_parenthesis' do
  it "returns an instance of #{described_class} if category is 括弧開" do
    opinion = described_class.new(%w(括弧開))
    opinion.and_left_parenthesis.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 括弧開' do
    opinion = described_class.new(%w(category))
    opinion.and_left_parenthesis.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_right_parenthesis' do
  it "returns an instance of #{described_class} if category is 括弧閉" do
    opinion = described_class.new(%w(括弧閉))
    opinion.and_right_parenthesis.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 括弧閉' do
    opinion = described_class.new(%w(category))
    opinion.and_right_parenthesis.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_comma' do
  it "returns an instance of #{described_class} if category is 読点" do
    opinion = described_class.new(%w(読点))
    opinion.and_comma.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 読点' do
    opinion = described_class.new(%w(category))
    opinion.and_comma.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_period' do
  it "returns an instance of #{described_class} if category is 句点" do
    opinion = described_class.new(%w(句点))
    opinion.and_period.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 句点' do
    opinion = described_class.new(%w(category))
    opinion.and_period.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::Yes, '#and_whitespace' do
  it "returns an instance of #{described_class} if category is 空白" do
    opinion = described_class.new(%w(空白))
    opinion.and_whitespace.should be_a described_class
  end

  it 'returns an instance of Langue::Japanese::Morpheme::No if category is not 空白' do
    opinion = described_class.new(%w(category))
    opinion.and_whitespace.should be_a Langue::Japanese::Morpheme::No
  end
end

describe Langue::Japanese::Morpheme::No do
  it 'extends Langue::Japanese::Morpheme::Opinion' do
    described_class.superclass.should == Langue::Japanese::Morpheme::Opinion
  end

  it 'is not so' do
    described_class.new([]).should_not be_so
  end
end

describe Langue::Japanese::Morpheme::No, '#next' do
  it 'returns self' do
    opinion = described_class.new([])
    next_opinion = opinion.next('category')
    next_opinion.should == opinion
  end
end
