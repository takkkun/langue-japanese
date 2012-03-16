module Langue
  module Japanese
    module MorphemeFilter
      def self.included(object)
        return if object.respond_to?(:filter)

        object.class_eval do
          def body_morphemes
            @body_morphemes ||= self.class.filters.inject(self) {|morphemes, filter| filter[self, morphemes]}
          end

          class << self
            def filters
              @filters ||= []
            end

            def filter(&filter)
              remove_instance_variable(:@body_morphemes) if instance_variable_defined?(:@body_morphemes)
              filters << filter
            end
          end
        end
      end
    end
  end
end
