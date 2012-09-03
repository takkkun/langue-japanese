require 'langue/japanese/inflector/inflections'
require 'langue/japanese/logging'

module Langue
  module Japanese
    class Inflector
      include Logging

      # Get the inflections.
      #
      # If given a block, define the inflections.
      #
      # @yield [] define the inflections
      def self.inflections(&define)
        (@inflections ||= Inflections.new).tap do |inflections|
          inflections.instance_eval(&define) if block_given?
        end
      end

      # @param [Hash] options
      # @option options [Logger] :logger
      def initialize(options = {})
        @logger = options[:logger] || null_logger
      end

      # Inflect the word.
      #
      # @param [String] classification the inflectional classification
      # @param [String] word root form of the word to inflect
      # @param [String] form the inflectional form
      # @param [Hash] options
      # @option options [String] :following
      # @option options [Boolean] :desu
      # @return [String] the inflected word
      def inflect(classification, word, form, options = {})
        inflection = self.class.inflections[classification]
        raise ArgumentError, %("#{classification}" inflection does not exist) unless inflection
        inflection.inflect(word, form, options)
      end
    end
  end
end

require 'langue/japanese/inflector/default'
