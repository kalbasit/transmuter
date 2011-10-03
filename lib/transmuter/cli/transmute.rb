module Transmuter
  module CLI
    module Transmute
      def self.included(base)
        base.send :include, InstanceMethods
      end

      module InstanceMethods
        def transmute!
          set_klasses!
          set_methods
          verify_klasses!

          source_klass_instance = @source_klass.new(read_input_file, parse_transmute_options)
          output = source_klass_instance.send(@source_transform_method)

          write_output_file(output)
        end

        def transmute
          transmute!
        rescue Exception => e
          handle_error(e)
        end

        protected
          def handle_error(exception)
            # TODO: Handle error properly
          end

          def set_klasses!
            @source_klass ||= "::Transmuter::Format::#{@input_fileformat.to_s.camelcase}".constantize
            @destination_klass ||= "::Transmuter::Format::#{@output_fileformat.to_s.camelcase}".constantize
          end

          def set_methods
            @source_transform_method ||= "to_#{@output_fileformat.to_s.downcase}".to_sym
            @destination_process_method ||= :process
          end

          def verify_klasses!

            raise NotImplementedError,
              "#{@source_klass} does not respond to #{@source_transform_method}" unless
              @source_klass.public_instance_methods.include?(@source_transform_method)

            raise NotImplementedError,
              "#{@destination_klass} does not respond to #{@destination_process_method}" unless
              @destination_klass.public_instance_methods.include?(@destination_process_method)
          end

          def read_input_file
            @input_file_contents ||= File.read(@input_filename)
          end

          def write_output_file(contents)
            File.open(@output_filename, 'w') { |f| f.write(contents) }
          end

          def parse_transmute_options
            { stylesheets: @stylesheets }
          end

      end
    end
  end
end