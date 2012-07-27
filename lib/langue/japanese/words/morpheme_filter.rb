module Langue
  module Japanese
    module MorphemeFilter
      def self.included(object)
        object.extend(ClassMethods)
      end

      def body_morphemes
        @body_morphemes ||= self.class.apply_filters(self)
      end

      def body
        @body = create_body unless instance_variable_defined?(:@body)
        @body
      end

      private

      def create_body
        return nil if body_morphemes.empty?

        morphemes = body_morphemes[0..-2].map(&:text)

        if inflection
          morphemes << body_morphemes[-1].root_form
        else
          morphemes << body_morphemes[-1].text
        end

        morphemes.join
      end

      module ClassMethods
        def filters
          @filters ||= []
        end

        def filter(&filter)
          remove_instance_variable(:@body_morphemes) if instance_variable_defined?(:@body_morphemes)
          filters << filter
        end

        def apply_filters(original_morphemes)
          filters.inject(original_morphemes) { |morphemes, filter| filter[original_morphemes, morphemes] }
        end
      end
    end
  end
end
