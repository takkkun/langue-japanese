require 'MeCab'

require 'langue/morpheme'
require 'langue/morphemes'
require 'langue/japanese/logging'

module Langue
  module Japanese
    class Parser
      include Logging

      def initialize(options = {})
        @mecab_options = options[:mecab_options] || {}
        @logger = options[:logger] || null_logger
        @taggers = {}
      end

      attr_accessor :mecab_options

      def parse(text)
        morphemes = Morphemes.new
        node = tagger.parseToNode(text)

        while node
          surface = node.surface.force_encoding('utf-8')

          unless surface.empty?
            feature = node.feature.force_encoding('utf-8')
            morphemes << create_morpheme(surface, feature)
          end

          node = node.next
        end

        morphemes
      end

      private

      def tagger
        @taggers[Thread.current] ||= MeCab::Tagger.new(mecab_options_as_string)
      end

      def mecab_options_as_string
        options = @mecab_options.inject([]) do |o, pair|
          key = pair[0].to_sym
          value = pair[1]

          case key
          when :sysdic
            o << '-d' << value
          when :userdic
            o << '-u' << value
          else
            map = {
              :level   => 'warn',
              :message => "'#{key}' option is unsupported",
              :key     => key
            }

            @logger.post('langue.japanese.parser', map)
            o
          end
        end

        options.compact.join(' ')
      end

      def create_morpheme(surface, feature)
        values = feature.split(',').map {|v| v == '*' ? nil : v}
        values[1..3] = [values[1..3].take_while {|value| !value.nil?}]
        values.unshift(surface.downcase)
        Morpheme.new(Hash[Morpheme::KEYS.zip(values)])
      end
    end
  end
end
