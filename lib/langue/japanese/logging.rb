module Langue
  class Japanese
    module Logging
      def null_logger
        return NullLogger.new unless Object.const_defined?(:Fluent)
        return NullLogger.new unless Fluent.const_defined?(:Logger)
        Fluent::Logger::NullLogger.open
      end

      class NullLogger
        def post(tag, map)
          post_with_time(tag, map, nil)
        end

        def post_with_time(tag, map, time)
          false
        end
      end
    end
  end
end
