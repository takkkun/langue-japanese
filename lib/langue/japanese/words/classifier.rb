# -*- coding: utf-8 -*-
module Langue
  module Japanese
    module Classifier
      {

        # noun
        :noun                  => %w(名詞),
        :noncategorematic_noun => %w(名詞 非自立),
        :noun_conjunct_to_suru => %w(名詞 サ変接続),
        :adverbable_noun       => %w(名詞 副詞可能),
        :adjective_stem_noun   => %w(名詞 形容動詞語幹),
        :pronoun               => %w(名詞 代名詞),

        # adjective
        :categorematic_adjective    => %w(形容詞 自立),
        :noncategorematic_adjective => %w(形容詞 非自立),

        # verb
        :categorematic_verb    => %w(動詞 自立),
        :noncategorematic_verb => %w(動詞 非自立),

        # auxiliary verb
        :auxiliary_verb => %w(助動詞),

        # particle
        :conjunctive_particle => %w(助詞 接続助詞),

        # prefix
        :noun_prefix      => %w(接頭詞 名詞接続),
        :adjective_prefix => %w(接頭詞 形容詞接続),
        :verb_prefix      => %w(接頭詞 動詞接続),

        # suffix
        :noun_suffix           => %w(名詞 接尾),
        :adjective_stem_suffix => %w(名詞 接尾 形容動詞語幹),
        :adjective_suffix      => %w(形容詞 接尾),
        :verb_suffix           => %w(動詞 接尾),

        # symbol
        :symbol   => %w(記号),
        :alphabet => %w(記号 アルファベット)

      }.each do |category, categories|
        define_method("#{category}?") do |morphemes, index|
          morphemes.at(index) {|m| m.classified?(*categories)}
        end
      end

      def first_noun?(morphemes, index)
         noun?(morphemes, index)                  &&
        !pronoun?(morphemes, index)               &&
        !adverbable_noun?(morphemes, index)       &&
        !noun_suffix?(morphemes, index)           &&
        !noncategorematic_noun?(morphemes, index)
      end

      def first_verb?(morphemes, index)
        categorematic_verb?(morphemes, index) && morphemes.at(index) do |m|
          !%w(する なる 思う おもう).include?(m.root_form)
        end
      end

      def first_adjective?(morphemes, index)
        categorematic_adjective?(morphemes, index)
      end

      def following_noun?(morphemes, index)
         noun?(morphemes, index)            &&
        !pronoun?(morphemes, index)         &&
        !adverbable_noun?(morphemes, index)
      end

      def following_adjective?(morphemes, index)
        (noncategorematic_adjective?(morphemes, index) || adjective_suffix?(morphemes, index)) && !ra5_special?(morphemes, index) ||
        auxiliary_verb?(morphemes, index)
      end

      def following_verb?(morphemes, index)
        (noncategorematic_verb?(morphemes, index) || verb_suffix?(morphemes, index)) && !ra5_special?(morphemes, index) ||
        auxiliary_verb?(morphemes, index)
      end

      def following_symbol?(morphemes, index)
        alphabet?(morphemes, index)
      end

      def suru_verb?(morphemes, index)
        categorematic_verb?(morphemes, index) && morphemes.at(index) {|m| m.inflected?('サ変・スル')}
      end

      def ra5_special?(morphemes, index)
        morphemes.at(index) {|m| m.inflected?('五段・ラ行特殊')}
      end
    end
  end
end
