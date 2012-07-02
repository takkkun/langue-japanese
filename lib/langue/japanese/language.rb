require 'langue'

module Langue
  module Japanese
    class Language < Langue::Language
      def parser
        @parser ||= Parser.new(@options)
      end
      depend_to :parser, 'langue/japanese/parser'

      def shaper
        @shaper ||= Shaper.new(@options)
      end
      depend_to :shaper, 'langue/japanese/shaper'

      def structurer
        @structurer ||= Structurer.new(@options)
      end
      depend_to :structurer, 'langue/japanese/structurer'

      def inflector
        @inflector ||= Inflector.new(@options)
      end
      depend_to :inflector, 'langue/japanese/inflector'

      def parse(text)
        parser.parse(text)
      end

      def shape_person_name(morphemes, person_name)
        shaper.shape_person_name(morphemes, person_name)
      end

      def structure(morphemes)
        structurer.structure(morphemes)
      end

      def inflect(classification, word, form, options = {})
        inflector.inflect(classification, word, form, options)
      end
    end
  end

  support(Japanese::Language)
end
