def operator_stub(file_name, class_name)
  stub.tap do |s|
    require "langue/japanese/#{file_name}" unless Langue::Japanese.const_defined?(class_name)
    Langue::Japanese.const_get(class_name).stub!(:new).and_return(s)
    yield s
  end
end

def parser_stub
  operator_stub('parser', :Parser) do |s|
    s.stub!(:parse).and_return('value returning from parse method')
    yield s if block_given?
  end
end

def shaper_stub
  operator_stub('shaper', :Shaper) do |s|
    s.stub!(:shape_person_name).and_return('value returning from shape_person_name method')
    yield s if block_given?
  end
end

def structurer_stub
  operator_stub('structurer', :Structurer) do |s|
    s.stub!(:structure).and_return('value returning from structure method')
    yield s if block_given?
  end
end

def inflector_stub
  operator_stub('inflector', :Inflector) do |s|
    s.stub!(:inflect).and_return('value returning from #inflect')
    yield s if block_given?
  end
end

def parser_tagger_stub(nodes = nil)
  stub.tap do |s|
    MeCab::Tagger.stub!(:new).and_return(s)

    if nodes
      node = make_node('')
      nodes.times { |i| node = make_node(nodes - i, node) }
      s.stub!(:parseToNode).and_return(make_node('', node))
    end

    yield s if block_given?
  end
end

def parser_model_stub(parser_tagger = nil)
  stub.tap do |s|
    MeCab::Model.stub!(:create).and_return(s)
    s.stub!(:createTagger).and_return(parser_tagger || parser_tagger_stub)
    yield s if block_given?
  end
end

def make_node(surface, next_node = nil)
  stub.tap do |s|
    s.stub!(:surface).and_return(surface.to_s)
    s.stub!(:feature).and_return('part_of_speech,category1,*,*,*,*,*,*')
    s.stub!(:next).and_return(next_node)
  end
end

def parser
  require 'langue/japanese/parser' unless defined? Langue::Japanese::Parser
  Langue::Japanese::Parser.new
end

def noun(text)
  morphemes = parser.parse(text)
  Langue::Japanese::Noun.new(morphemes)
end

def adjective(text)
  morphemes = parser.parse(text)
  Langue::Japanese::Adjective.new(morphemes)
end

def adjectival_noun(text)
  morphemes = parser.parse(text)
  Langue::Japanese::AdjectivalNoun.new(morphemes)
end

def verb(text)
  morphemes = parser.parse(text)
  Langue::Japanese::Verb.new(morphemes)
end

def period(text)
  morphemes = parser.parse(text)
  Langue::Japanese::Period.new(morphemes)
end
