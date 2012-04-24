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

      def body
        unless instance_variable_defined?(:@body)
          @body = if body_morphemes.empty?
                    nil
                  else
                    morphemes = body_morphemes.dup
                    last_morpheme = morphemes.pop
                    morphemes.map(&:text).join + last_morpheme.root_form
                  end
        end

        @body
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
        if auxiliary_verb_index('特殊・ナイ')
          true
        elsif index = auxiliary_verb_index('特殊・ヌ')
          morphemes.at(index - 1) { |m| m.inflection_type == '未然形' }
        elsif index = auxiliary_verb_index('特殊・マス') { |m| m.inflection_type == '未然形' }
          morphemes.at(index + 1) { |m| m.classified?('助動詞') && m.root_form == 'ん' }
        else
          na_final_particle?
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
        self[-1].inflection_type =~ /^命令/ || na_final_particle? || ta_conjunctive_particle?
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

      def na_final_particle?
        morphemes.at(-1) { |m| m.classified?('助詞', '終助詞') && m.root_form == 'な' } &&
        morphemes.at(-2) { |m| m.classified?('動詞') && m.inflection_type == '基本形' }
      end

      def ta_conjunctive_particle?
        index = size - 1
        index -= 1 while morphemes.at(index) { |m| m.classified?('助詞', '終助詞') }
        morphemes.at(index) { |m| m.classified?('助詞', '接続助詞') && %w(て で).include?(m.root_form) }
      end
    end
  end
end
