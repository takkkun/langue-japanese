# -*- coding: utf-8 -*-
require 'langue/morpheme'

module Langue
  class Japanese
    class Morpheme < Langue::Morpheme
      PARTS_OF_SPEECH = {
        :noun           => '名詞',
        :prefix         => '接頭詞',
        :adjective      => '形容詞',
        :verb           => '動詞',
        :adverb         => '副詞',
        :particle       => '助詞',
        :auxiliary_verb => '助動詞',
        :conjunction    => '接続詞',
        :determiner     => '連体詞',
        :interjection   => '感動詞',
        :symbol         => '記号',
        :filler         => 'フィラー',
        :other          => 'その他'
      }

      CATEGORIES = {
        :general                    => '一般',
        :special                    => '特殊',
        :proper                     => '固有名詞',
        :person                     => '人名',
        :surname                    => '姓',
        :forename                   => '名',
        :organization               => '組織',
        :place                      => '地域',
        :country                    => '国',
        :quantity                   => '数',
        :suffix                     => '接尾',
        :quantifier                 => '助数詞',
        :pronoun                    => '代名詞',
        :adverbization              => '副詞化',
        :attributivization          => '連体化',
        :adverbable                 => '副詞可能',
        :noun_conjunction           => '名詞接続',
        :quantity_conjunction       => '数接続',
        :suru_conjunction           => 'サ変接続',
        :adjective_conjunction      => '形容詞接続',
        :verb_conjunction           => '動詞接続',
        :particle_conjunction       => '助詞類接続',
        :adjective_verb_stem        => '形容動詞語幹',
        :auxiliary_verb_stem        => '助動詞語幹',
        :nai_adjective_stem         => 'ナイ形容詞語幹',
        :verb_noncategorematic_like => '動詞非自立的',
        :conjunction_like           => '接続詞的',
        :interjection               => '間投',
        :contraction                => '縮約',
        :collocation                => '連語',
        :quotation                  => '引用',
        :categorematic              => '自立',
        :noncategorematic           => '非自立',
        :nominative                 => '格助詞',
        :binding                    => '係助詞',
        :supplementary              => '副助詞',
        :conjunctive                => '接続助詞',
        :parallel                   => '並立助詞',
        :final                      => '終助詞',
        :ka                         => '副助詞／並立助詞／終助詞',
        :alphabet                   => 'アルファベット',
        :left_parenthesis           => '括弧開',
        :right_parenthesis          => '括弧閉',
        :comma                      => '読点',
        :period                     => '句点',
        :whitespace                 => '空白'
      }

      def self.from_mecab_node(surface, feature)
        values = feature.split(',').map {|v| v == '*' ? nil : v}
        values[1..3] = [values[1..3].take_while {|value| !value.nil?}]
        values.unshift(surface)
        new(Hash[KEYS.zip(values)])
      end

      PARTS_OF_SPEECH.each do |part_of_speech, part_of_speech_ja|
        define_method("is_#{part_of_speech}") do
          @part_of_speech == part_of_speech_ja ? Yes.new(@categories) : No.new([])
        end
      end

      class Opinion
        def initialize(categories)
          @categories = categories
        end

        CATEGORIES.each do |category, category_ja|
          define_method("and_#{category}") { self.next(category_ja) }
        end
      end

      class Yes < Opinion
        def so?
          true
        end

        def next(category)
          @categories.first == category ? self.class.new(@categories[1..-1]) : No.new([])
        end
      end

      class No < Opinion
        def so?
          false
        end

        def next(category)
          self
        end
      end
    end
  end
end
