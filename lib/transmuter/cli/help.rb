module Transmuter
  class CLI
    module Help
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def help
        end
      end
    end
  end
end