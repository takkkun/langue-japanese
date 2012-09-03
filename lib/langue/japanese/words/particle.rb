require 'langue/word'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Particle < ::Langue::Particle
      extend Classifier

      def self.take(morphemes, index)
        if particle?(morphemes, index)
          take_particle(morphemes, index)
        else
          0
        end
      end

      def self.take_particle(morphemes, index)
        size = 0
        size += 1 while particle?(morphemes, index + size) && !conjunctive_particle?(morphemes, index + size)
        size
      end
    end
  end
end
