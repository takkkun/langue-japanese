require 'langue/word'
require 'langue/japanese/words/prefix'
require 'langue/japanese/words/attribute'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Adjective < ::Langue::Adjective
      include Prefix
      include Attribute

      has :negative, :perfective

      class << self
        include Classifier

        def take(morphemes, index)
          if first_adjective?(morphemes, index)
            take_adjective(morphemes, index)
          elsif adjective_prefix?(morphemes, index)
            take_adjective_with_prefix(morphemes, index)
          else
            0
          end
        end

        def take_adjective(morphemes, index)
          return 0 unless first_adjective?(morphemes, index)
          size = 1
          size += 1 while following_adjective?(morphemes, index + size) || conjunctive_particle?(morphemes, index + size) && following_adjective?(morphemes, index + size + 1)
          size += 1 while auxiliary_verb?(morphemes, index + size)
          size
        end

        def take_adjective_with_prefix(morphemes, index)
          size = 0
          size += 1 while adjective_prefix?(morphemes, index + size)
          return 0 unless size > 0
          next_size = take_adjective(morphemes, index + size)
          next_size > 0 ? size + next_size : 0
        end
      end

      def key_morpheme
        unless instance_variable_defined?(:@key_morpheme)
          @key_morpheme = if empty?
                            nil
                          else
                            index = size - 1
                            index -= 1 while !self.class.body_adjective?(morphemes, index)
                            self[index]
                          end
        end

        @key_morpheme
      end

      def prefix_morphemes
        @prefix_morphemes ||= begin
                                size = 0
                                size += 1 while self.class.adjective_prefix?(morphemes, size)
                                morphemes[0, size]
                              end
      end
    end
  end
end
