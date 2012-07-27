require 'langue/word'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Adverb < ::Langue::Adverb
      extend Classifier

      def self.take(morphemes, index)
        if adverb?(morphemes, index)
          take_adverb(morphemes, index)
        else
          0
        end
      end

      def self.take_adverb(morphemes, index)
        size = 0
        size += 1 while adverb?(morphemes, index + size)
        size
      end
    end
  end
end
