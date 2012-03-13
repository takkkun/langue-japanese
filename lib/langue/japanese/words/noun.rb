# -*- coding: utf-8 -*-
require 'langue/word'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Noun < Word
      class << self
        include Classifier

        def take(morphemes, index)
          if first_noun?(morphemes, index)
            take_noun(morphemes, index)
          elsif noun_prefix?(morphemes, index)
            take_noun_with_prefix(morphemes, index)
          elsif adverbable_noun?(morphemes, index)
            take_adverbable_noun(morphemes, index)
          else
            0
          end
        end

        def take_noun(morphemes, index)
          return 0 unless first_noun?(morphemes, index)
          all = adjective_stem_noun?(morphemes, index)
          size = 1

          while following_noun?(morphemes, index + size) || following_symbol?(morphemes, index + size)
            all &&= adjective_stem_noun?(morphemes, index + size)
            size += 1
          end

          return 0 if all
          return 0 if noun_conjunct_to_suru?(morphemes, index + size - 1) && suru_verb?(morphemes, index + size)
          return 0 if morphemes[index].text[0] == 'ー'
          size
        end

        def take_noun_with_prefix(morphemes, index)
          size = 0
          size += 1 while noun_prefix?(morphemes, index + size)
          return 0 unless size > 0
          next_size = take_noun(morphemes, index + size)
          next_size > 0 ? size + next_size : 0
        end

        def take_adverbable_noun(morphemes, index)
          size = 0
          size += 1 while adverbable_noun?(morphemes, index + size)
          size
        end
      end
    end
  end
end
