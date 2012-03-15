# -*- coding: utf-8 -*-
require 'langue/japanese/structurer'
require 'langue/japanese/parser'
require 'yaml'

describe Langue::Japanese::Structurer, '::WORD_CLASSES' do
  before do
    @word_classes = Langue::Japanese::Structurer::WORD_CLASSES
  end

  it 'has the word classes' do
    @word_classes.should == [
      Langue::Japanese::Period,
      Langue::Japanese::Verb,
      Langue::Japanese::Adjective,
      Langue::Japanese::AdjectiveNoun,
      Langue::Japanese::Pronoun,
      Langue::Japanese::Noun
    ]
  end

  it 'has take in all' do
    @word_classes.each do |word_class|
      word_class.should be_respond_to :take
    end
  end
end

describe Langue::Japanese::Structurer, '#structure' do
  before :all do
    @parser = Langue::Japanese::Parser.new
    @morphemes = @parser.parse('今日は妹と一緒にお買い物してきたよ。楽しかった〜')
    @word_classes = Langue::Japanese::Structurer::WORD_CLASSES
  end

  before do
    @structurer = described_class.new
  end

  it 'returns an instance of Langue::Text' do
    text = @structurer.structure(@morphemes)
    text.should be_a Langue::Text
  end

  it 'returns valid text' do
    text = @structurer.structure(@morphemes)
    text.should be_valid
  end

  it 'returns sentences in the text' do
    text = @structurer.structure(@morphemes)
    text.should have(2).items
  end

  it 'returns words in the sentences' do
    text = @structurer.structure(@morphemes)
    text[0].should have(9).items
    text[1].should have(2).items
  end

  YAML.load_file(File.join(File.dirname(__FILE__), 'data.yaml')).each do |data|
    input = data['text']
    sentences = data['sentences']

    it "extracts expected words from #{input.size < 10 ? input : input[0..7] + '...'}" do
      morphemes = @parser.parse(input)
      text = @structurer.structure(morphemes)
      text.should have(sentences.size).items

      text.each_with_index do |sentence, index|
        sentence = sentence.select {|word| !word.instance_of?(Langue::Word)}
        words = sentences[index]
        sentence.should have(words.size).items

        words.zip(sentence).each do |pair|
          pair[1].text.should == pair[0][0]
          pair[1].class.name.split('::').last.should == pair[0][1]
          next unless pair[0][2]

          pair[0][2].each do |name, value|
            got = pair[1].__send__(name)

            if TrueClass === value
              got.should be_true
            elsif FalseClass === value
              got.should be_false
            else
              got.should == value
            end
          end
        end
      end
    end
  end
end
