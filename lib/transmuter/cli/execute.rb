module Transmuter
  module CLI
    module Execute
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def execute!
        end

        def execute
        end
      end
    end
  end
end