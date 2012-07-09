# -*- coding: utf-8 -*-
module Langue
  module Japanese
    class Inflector
      class Inflection
        NIGORU = {
          'た' => 'だ',
          'ち' => 'じ',
          'て' => 'で',
          'と' => 'ど'
        }

        SUMU = NIGORU.invert.merge('ぢ' => 'ち')

        # @param [String] base_suffix the base suffix
        # @param [Hash<String, String>] suffixes suffix for each the
        #   inflectional form
        def initialize(base_suffix, suffixes)
          @base_suffix = base_suffix
          @suffixes = suffixes
        end

        # Inflect the word.
        #
        # @param [String] word root form of the word to inflect
        # @param [String] form the inflectional form
        # @param [Hash] options
        # @option options [String] :following
        # @option options [Boolean] :desu
        # @return [String] the inflected word
        def inflect(word, form, options = {})
          raise ArgumentError, %(the word does not end with "#{@base_suffix}") unless word.end_with?(@base_suffix)
          stem = word.chomp(@base_suffix)

          suffix = @suffixes[form]
          raise ArgumentError, %("#{form}" inflectional form does not defined in the inflection) unless suffix
          suffix = suffix[options] if suffix.is_a?(Proc)

          following = options[:following] || ''

          if %w(連用タ接続 連用テ接続).include?(form)
            nigoru = false
            suffix, nigoru = suffix if suffix.is_a?(Array)
            following = affect(following, nigoru ? NIGORU : SUMU)
          end

          stem + suffix + following
        end

        private

        def affect(text, map)
          prefix = map.keys.find { |p| text.start_with?(p) }
          prefix ? text.sub(/^#{prefix}/, map[prefix]) : text
        end
      end
    end
  end
end
