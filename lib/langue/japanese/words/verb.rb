require 'langue/word'
require 'langue/japanese/words/classifier'
require 'langue/japanese/words/with_prefix'

module Langue
  module Japanese
    class Verb < Word
      include WithPrefix

      class << self
        include Classifier

        def take(morphemes, index)
          if first_verb?(morphemes, index)
            take_verb(morphemes, index)
          elsif verb_prefix?(morphemes, index)
            take_verb_with_prefix(morphemes, index)
          elsif first_noun?(morphemes, index)
            take_noun_conjunct_to_suru(morphemes, index)
          elsif noun_prefix?(morphemes, index)
            take_noun_with_prefix_conjunct_to_suru(morphemes, index)
          else
            0
          end
        end

        def take_verb(morphemes, index)
          return 0 unless first_verb?(morphemes, index)
          take_following_verb(morphemes, index)
        end

        def take_verb_with_prefix(morphemes, index)
          size = 0
          size += 1 while verb_prefix?(morphemes, index + size)
          return 0 unless size > 0
          next_size = take_verb(morphemes, index + size)
          next_size > 0 ? size + next_size : 0
        end

        def take_noun_conjunct_to_suru(morphemes, index)
          size = 0
          size += 1 while following_noun?(morphemes, index + size)
          return 0 unless size > 0
          return 0 unless noun_conjunct_to_suru?(morphemes, index + size - 1)
          return 0 unless suru_verb?(morphemes, index + size)
          size + take_following_verb(morphemes, index + size)
        end

        def take_noun_with_prefix_conjunct_to_suru(morphemes, index)
          size = 0
          size += 1 while noun_prefix?(morphemes, index + size)
          return 0 unless size > 0
          next_size = take_noun_conjunct_to_suru(morphemes, index + size)
          next_size > 0 ? size + next_size : 0
        end

        private

        def take_following_verb(morphemes, index)
          size = 1
          size += 1 while following_verb?(morphemes, index + size) || conjunctive_particle?(morphemes, index + size) && following_verb?(morphemes, index + size + 1)
          size += 1 while auxiliary_verb?(morphemes, index + size)
          size
        end
      end

      protected

      def take_prefix
        size = 0

        if self.class.verb_prefix?(morphemes, size)
          size += 1 while self.class.verb_prefix?(morphemes, size)
        elsif self.class.noun_prefix?(morphemes, size)
          size += 1 while self.class.noun_prefix?(morphemes, size)
        end

        size
      end
    end
  end
end
