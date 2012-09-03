# -*- coding: utf-8 -*-
require 'langue/morpheme'
require 'langue/morphemes'
require 'langue/japanese/logging'

module Langue
  module Japanese
    class Shaper
      include Logging

      def initialize(options = {})
        @logger = options[:logger] || null_logger
      end

      def shape_person_name(morphemes, person_name)
        Morphemes.new.tap do |new_morphemes|
          person_name_morphemes = []
          start_index = 0
          person_name_size = person_name.size

          morphemes.each do |morpheme|
            text = morpheme.text
            index = person_name.index(text, start_index)

            if index == start_index
              person_name_morphemes << morpheme
              start_index += text.size

              if start_index == person_name_size
                new_morphemes << join_as_person_name(person_name_morphemes)
                person_name_morphemes.clear
                start_index = 0
              end
            else
              new_morphemes.concat(person_name_morphemes) << morpheme
              person_name_morphemes.clear
              start_index = 0
            end
          end
        end
      end

      private

      def join_as_person_name(morphemes)
        text = morphemes.map(&:text).join

        yomi = morphemes.inject('') do |yomi, morpheme|
          t = morpheme.text
          y = morpheme.yomi
          yomi + (y || t != 'ー' ? (y || '') : t)
        end

        pronunciation = morphemes.inject('') do |pronunciation, morpheme|
          pronunciation + (morpheme.pronunciation || '')
        end

        Morpheme.new(
          :text           => text,
          :part_of_speech => '名詞',
          :categories     => %w(固有名詞 人名),
          :root_form      => text,
          :yomi           => yomi,
          :pronunciation  => pronunciation
        )
      end
    end
  end
end
