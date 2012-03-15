require 'langue/japanese/words/text_filter'

module Langue
  module Japanese
    module WithPrefix
      def self.included(object)
        object.class_eval do
          include TextFilter
          filter {|word, text| text[word.prefix.size..-1]}
        end
      end

      def prefix
        @prefix = prefix_morphemes.map(&:text).join unless instance_variable_defined?(:@prefix)
        @prefix
      end

      private

      def prefix_morphemes
        self[0, respond_to?(:take_prefix) ? take_prefix : 0]
      end
    end
  end
end
