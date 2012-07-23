# -*- coding: utf-8 -*-
require 'langue/japanese/words/morpheme_filter'

module Langue
  module Japanese
    module Attribute
      def self.included(object)
        object.class_eval do
          include MorphemeFilter
          filter { |word, morphemes| word.empty? ? morphemes : morphemes[0..morphemes.index(word.key_morpheme)] }

          def self.has(*attrs)
            attrs.each do |attr|
              define_method("#{attr}?") do
                @attrs ||= {}
                @attrs[attr] = !!__send__("include_#{attr}?") unless @attrs.key?(attr)
                @attrs[attr]
              end
            end
          end
        end
      end

      if RUBY_VERSION.to_f < 1.9
        def index(value = nil)
          if value
            super
          else
            each_with_index { |morpheme, index| return index if yield morpheme }
            nil
          end
        end
      end

      private

      def include_progressive?
        if noncategorematic_verb_index(%w(てる でる とる どる))
          true
        elsif index = noncategorematic_verb_index(['いる'])
          morphemes.at(index - 1) { |m| m.classified?('助詞', '接続助詞') && %w(て で).include?(m.root_form) }
        end
      end

      def include_passive?
        verb_suffix_index(%w(れる られる))
      end

      def include_causative?
        verb_suffix_index(%w(せる させる))
      end

      def include_aggressive?
        auxiliary_verb_index('特殊・タイ')
      end

      def include_negative?
        if nai_auxiliary_verb_count.odd?
          true
        elsif index = auxiliary_verb_index('特殊・ヌ')
          morphemes.at(index - 1) { |m| m.inflection_type == '未然形' }
        elsif index = auxiliary_verb_index('特殊・マス') { |m| m.inflection_type == '未然形' }
          morphemes.at(index + 1) { |m| m.classified?('助動詞') && m.root_form == 'ん' }
        else
          na_final_particle_with_conclusive?
        end
      end

      def include_perfective?
        if auxiliary_verb_index('特殊・タ')
          true
        elsif index = index { |m| m.classified?('助動詞') && m.root_form == 'ぬ' }
          morphemes.at(index - 1) { |m| m.inflection_type == '連用形' }
        end
      end

      def include_imperative?
        last = reverse.drop_while { |m| m.classified?('助詞', '終助詞') }.first

        (last and last.inflection_type =~ /^命令/) ||
        na_final_particle_with_conclusive?         ||
        na_final_particle_with_conjunctive?        ||
        ta_conjunctive_particle?
      end

      def noncategorematic_verb_index(root_forms)
        index { |m| m.classified?('動詞', '非自立') && root_forms.include?(m.root_form) }
      end

      def auxiliary_verb_index(inflection)
        index { |m| m.classified?('助動詞') && m.inflected?(inflection) && (block_given? ? yield(m) : true) }
      end

      def verb_suffix_index(root_forms)
        index { |m| m.classified?('動詞', '接尾') && root_forms.include?(m.root_form) }
      end

      def nai_auxiliary_verb_count
        count { |m| m.classified?('助動詞') && m.inflected?('特殊・ナイ') }
      end

      def ta_conjunctive_particle?
        index = size - 1
        index -= 1 while morphemes.at(index) { |m| m.classified?('助詞', '終助詞') }
        morphemes.at(index) { |m| m.classified?('助詞', '接続助詞') && %w(て で).include?(m.root_form) }
      end

      def na_final_particle_with_conjunctive?
        na_final_particle? &&
        morphemes.at(-2) { |m| m.classified?('動詞') && m.inflection_type == '連用形' }
      end

      def na_final_particle_with_conclusive?
        na_final_particle? &&
        morphemes.at(-2) { |m| m.classified?('動詞') && m.inflection_type == '基本形' }
      end

      def na_final_particle?
        morphemes.at(-1) { |m| m.classified?('助詞', '終助詞') && m.root_form == 'な' }
      end
    end
  end
end
