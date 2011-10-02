module Transmuter
  module CLI
    module Transmute
      def self.included(base)
        base.send :include, InstanceMethods
      end

      module InstanceMethods
        def transmute!
          from_klass = "::Transmuter::Formats::#{@input_fileformat.to_s}".constantize
        end

        def transmute
          transmute!
        rescue Exception => e
          handle_error(e)
        end

        def handle_error(exception)
          # TODO!
        end

      end
    end
  end
end