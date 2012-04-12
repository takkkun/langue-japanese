require 'langue/japanese/words/morpheme_filter'

module Langue
  module Japanese
    module Prefix
      def self.included(object)
        object.class_eval do
          include MorphemeFilter
          filter { |word, morphemes| morphemes[word.prefix_morphemes.size..-1] }
        end
      end

      def prefix
        @prefix = prefix_morphemes.map(&:text).join unless instance_variable_defined?(:@prefix)
        @prefix
      end
    end
  end
end
