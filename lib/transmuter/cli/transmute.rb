module Transmuter
  module CLI
    module Transmute
      def self.included(base)
        base.send :include, InstanceMethods
      end

      module InstanceMethods
        def transmute!
        end

        def transmute
          transmute!
        end
      end
    end
  end
end