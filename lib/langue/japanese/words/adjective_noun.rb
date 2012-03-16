require 'langue/japanese/words/noun'
require 'langue/japanese/words/prefix'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class AdjectiveNoun < Noun
      include Prefix

      class << self
        include Classifier

        def take(morphemes, index)
          if adjective_stem_noun?(morphemes, index)
            take_adjective_stem_noun(morphemes, index)
          elsif first_noun?(morphemes, index)
            take_noun_with_suffix(morphemes, index)
          elsif noun_prefix?(morphemes, index)
            take_noun_with_prefix(morphemes, index)
          else
            0
          end
        end

        def take_adjective_stem_noun(morphemes, index)
          size = 0
          size += 1 while adjective_stem_noun?(morphemes, index + size)
          return 0 unless size > 0

          if adjective_stem_suffix?(morphemes, index + size)
            size
          elsif following_noun?(morphemes, index + size)
            0
          else
            size
          end
        end

        def take_noun_with_suffix(morphemes, index)
          return 0 unless first_noun?(morphemes, index)
          size = 1
          size += 1 while following_noun?(morphemes, index + size) && !adjective_stem_suffix?(morphemes, index + size)
          return 0 unless adjective_stem_suffix?(morphemes, index + size)
          size += 1 while adjective_stem_suffix?(morphemes, index + size)

          if following_noun?(morphemes, index + size)
            0
          else
            size
          end
        end

        def take_noun_with_prefix(morphemes, index)
          size = 0
          size += 1 while noun_prefix?(morphemes, index + size)
          return 0 unless size > 0
          next_size = take(morphemes, index + size)
          next_size > 0 ? size + next_size : 0
        end
      end

      def prefix_morphemes
        @prefix_morphemes ||= begin
                                size = 0
                                size += 1 while self.class.noun_prefix?(morphemes, size)
                                morphemes[0, size]
                              end
      end

      def body
        @body = body_morphemes.empty? ? nil : body_morphemes.map(&:text).join unless instance_variable_defined?(:@body)
        @body
      end
    end
  end
end
