require 'langue/japanese/words/morpheme_filter'

module Langue
  module Japanese
    module Prefix
      def self.included(object)
        object.class_eval { include MorphemeFilter }
        object.filter { |word, morphemes| morphemes[word.prefix_morphemes.size..-1] }
      end

      def prefix_morphemes
        @prefix_morphemes ||= extract_prefix_morphemes
      end

      def prefix
        @prefix = create_prefix unless instance_variable_defined?(:@prefix)
        @prefix
      end

      private

      def create_prefix
        prefix_morphemes.map(&:text).join
      end
    end
  end
end
