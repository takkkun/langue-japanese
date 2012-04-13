require 'langue'

module Langue
  module Japanese
    class Language < Langue::Language
      def parser
        @parser ||= Parser.new(@options)
      end
      depend_to :parser, 'langue/japanese/parser'

      def structurer
        @structurer ||= Structurer.new(@options)
      end
      depend_to :structurer, 'langue/japanese/structurer'

      def parse(text)
        parser.parse(text)
      end

      def structure(morphemes)
        structurer.structure(morphemes)
      end
    end
  end

  support(Japanese::Language)
end
