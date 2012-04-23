require 'langue/word'
require 'langue/japanese/words/classifier'

module Langue
  module Japanese
    class Conjunction < ::Langue::Conjunction
      class << self
        include Classifier

        def take(morphemes, index)
          if conjunction?(morphemes, index)
            1
          else
            0
          end
        end
      end
    end
  end
end
