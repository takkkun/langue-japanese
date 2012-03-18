require 'langue/morpheme'

module Langue
  module Japanese
    class Morpheme < Langue::Morpheme
      def self.from_mecab_node(surface, feature)
        values = feature.split(',').map {|v| v == '*' ? nil : v}
        values[1..3] = [values[1..3].take_while {|value| !value.nil?}]
        values.unshift(surface.downcase)
        new(Hash[KEYS.zip(values)])
      end

      def classified?(part_of_speech, *categories)
        got = [@part_of_speech] + @categories
        expected = [part_of_speech] + categories
        expected.zip(got).all? {|pair| pair[0] == pair[1]}
      end

      def inflected?(inflection)
        @inflection == inflection
      end
    end
  end
end
