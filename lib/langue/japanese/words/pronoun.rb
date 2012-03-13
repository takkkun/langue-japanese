require 'langue/japanese/words/noun'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Pronoun < Noun
      class << self
        include Classifier

        def take(morphemes, index)
          pronoun?(morphemes, index) ? 1 : 0
        end
      end
    end
  end
end
