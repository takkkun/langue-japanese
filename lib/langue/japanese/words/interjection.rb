require 'langue/word'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Interjection < ::Langue::Interjection
      class << self
        include Classifier

        def take(morphemes, index)
          if interjection?(morphemes, index)
            1
          else
            0
          end
        end
      end
    end
  end
end
