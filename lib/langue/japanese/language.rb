require 'langue'

module Langue
  module Japanese
    class Language < Langue::Language
      def parse(text)
        (@parser ||= Parser.new(@options)).parse(text)
      end
      depend_to :parse, 'langue/japanese/parser'

      def structure(morphemes)
        (@structurer ||= Structurer.new(@options)).structure(morphemes)
      end
      depend_to :structure, 'langue/japanese/structurer'
    end
  end

  support(Japanese::Language)
end
