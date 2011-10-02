module Transmuter
  module CLI
    module Execute
      def self.included(base)
        base.send :include, InstanceMethods
      end

      module InstanceMethods
        def execute!
        end

        def execute
        end
      end
    end
  end
end