require 'langue/word'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Determiner < ::Langue::Determiner
      extend Classifier

      def self.take(morphemes, index)
        if determiner?(morphemes, index)
          take_determiner(morphemes, index)
        else
          0
        end
      end

      def self.take_determiner(morphemes, index)
        size = 0
        size += 1 while determiner?(morphemes, index + size)
        size
      end
    end
  end
end
