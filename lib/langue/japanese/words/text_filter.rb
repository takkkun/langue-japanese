module Langue
  module Japanese
    module TextFilter
      def self.included(object)
        return if object.public_instance_methods.include?(:full_text)

        object.class_eval do
          alias full_text text

          @@filters = []

          def text
            @filtered_text = @@filters.inject(full_text) {|text, filter| filter[self, text]} unless instance_variable_defined?(:@filtered_text)
            @filtered_text
          end

          def self.filter(&filter)
            remove_instance_variable(:@filtered_text) if instance_variable_defined?(:@filtered_text)
            @@filters << filter
          end
        end
      end
    end
  end
end
