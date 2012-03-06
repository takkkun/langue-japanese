require 'langue'
require 'langue/japanese/version'

module Langue
  class Japanese
    include Language

    def parse(text)
      (@parser ||= Parser.new(@options)).parse(text)
    end
    depend_to :parse, 'langue/japanese/parser'

    def structuralize(morphemes)
      morphemes = parse(morphemes) if String === morphemes
      (@structuralizer ||= Structuralizer.new(@options)).structuralize(morphemes)
    end
    depend_to :structuralize, 'langue/japanese/structuralizer'
  end

  support Japanese
end
