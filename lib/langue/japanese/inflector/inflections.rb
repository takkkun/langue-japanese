require 'langue/japanese/inflector/inflection'

module Langue
  module Japanese
    class Inflector
      class Inflections < Hash

        # Define the inflection.
        #
        # @param [String] classification the inflectional classification
        # @param [String] base_suffix the base suffix
        # @param [Hash<String, String>] suffixes suffix for each the
        #   inflectional form
        def inflection(classification, base_suffix, suffixes = {})
          if categorizing?
            parts = []
            inadequate = @required_forms - suffixes.keys
            parts << "#{enumerate_forms(inadequate)} has not been defined" unless inadequate.empty?
            excess = suffixes.keys - @required_forms
            parts << "#{enumerate_forms(excess)} should not be defined" unless excess.empty?
            raise ArgumentError, "#{parts.join(', and ')}" unless parts.empty?
          end

          self[classification] = Inflection.new(base_suffix, suffixes)
        end

        # Make the category for inflections.
        #
        # @param [Array<String>] required_forms inflectional forms that
        #   inflections in the category need
        # @yield [] define inflections
        def category(*required_forms, &define)
          @required_forms = required_forms
          instance_eval(&define) if block_given?
        ensure
          remove_instance_variable(:@required_forms)
        end

        # Determine if you are defining inflections with a category.
        #
        # @return whether if you are defining inflections with a category
        def categorizing?
          instance_variable_defined?(:@required_forms)
        end

        private

        def enumerate_forms(forms)
          last = forms.last
          other = forms[0..-2].join(', ')
          other.empty? ? last : "#{other} and #{last}"
        end
      end
    end
  end
end
