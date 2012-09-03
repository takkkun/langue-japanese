require 'langue/word'
require 'langue/japanese/words/prefix'
require 'langue/japanese/words/attribute'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class InvalidWord < StandardError; end

    class Adjective < ::Langue::Adjective
      include Prefix

      def extract_prefix_morphemes
        size = 0
        size += 1 while self.class.adjective_prefix?(morphemes, size)
        morphemes[0, size]
      end

      include Attribute

      has :negative, :perfective

      extend Classifier

      def self.take(morphemes, index)
        if first_adjective?(morphemes, index)
          take_adjective(morphemes, index)
        elsif adjective_prefix?(morphemes, index)
          take_adjective_with_prefix(morphemes, index)
          else
          0
        end
      end

      def self.take_adjective(morphemes, index)
        return 0 unless first_adjective?(morphemes, index)
        size = 1
        size += 1 while following_adjective?(morphemes, index + size) || conjunctive_particle?(morphemes, index + size) && following_adjective?(morphemes, index + size + 1)
        size += 1 while auxiliary_verb?(morphemes, index + size)
        size
      end

      def self.take_adjective_with_prefix(morphemes, index)
        size = 0
        size += 1 while adjective_prefix?(morphemes, index + size)
        return 0 unless size > 0
        next_size = take_adjective(morphemes, index + size)
        next_size > 0 ? size + next_size : 0
      end

      def key_morpheme
        unless instance_variable_defined?(:@key_morpheme)
          @key_morpheme = if empty?
                            nil
                          else
                            index = size - 1

                            while !self.class.body_adjective?(morphemes, index)
                              index -= 1
                              raise InvalidWord, %("#{text}" is invalid a word as an adjective) unless self[index]
                            end

                            self[index]
                          end
        end

        @key_morpheme
      end
    end
  end
end
