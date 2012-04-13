require 'active_support/core_ext/string/inflections'

require 'langue/text'
require 'langue/sentence'
require 'langue/word'
require 'langue/japanese/logging'

module Langue
  module Japanese
    class Structurer
      include Logging

      WORD_CLASSES = %w(
        period
        verb
        adjective
        adjective_noun
        pronoun
        noun
      ).map do |word_name|
        require "langue/japanese/words/#{word_name}"
        Langue::Japanese.const_get(word_name.camelize)
      end

      def initialize(options = {})
        @logger = options[:logger] || null_logger
      end

      def structure(morphemes)
        sentences = []
        words = []
        arrived = false
        index = 0
        length = morphemes.length

        while index < length
          word_class = nil
          size = 0

          WORD_CLASSES.each do |wc|
            s = wc.take(morphemes, index)

            if s > 0
              word_class = wc
              size = s
              break
            end
          end

          if word_class.nil?
            word_class = Word
            size = 1
          end

          word = word_class.new(morphemes[index, size])

          if arrived && !word.instance_of?(Period)
            sentences << Sentence.new(words)
            words.clear
            arrived = false
          elsif word.instance_of?(Period)
            arrived = true
          end

          words << word
          index += size
        end

        sentences << Sentence.new(words) unless words.empty?
        Text.new(sentences)
      end
    end
  end
end
