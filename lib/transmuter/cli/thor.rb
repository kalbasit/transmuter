require 'thor'
require 'thor/group'

module Transmuter
  class CLI < Thor::Group
    desc "Transmute one file format into another"

    class_option :input_format,
      type: :string,
      required: false,
      aliases: "-f",
      desc: "The input format."

    class_option :output_format,
      type: :string,
      required: false,
      aliases: "-t",
      default: "pdf",
      desc: "The output format."

    argument :input,
      type: :string,
      required: true,
      aliases: "-i",
      desc: "The input file name."

    argument :output,
      type: :string,
      required: false,
      aliases: "-o",
      desc: "The output file name."

    def set_input_filename
      @input_filename = input
    end

    def set_input_fileformat
      @input_fileformat = options[:input_format] || input_format
    end

    def set_output_fileformat
      @output_fileformat = options[:output_format]
    end

    def set_output_filename
      if output.blank? && options[:output_format].blank?
        raise ArgumentError, "Either output or output_format should be given,"
      end

      @output_filename = output || output_file
    end

    protected

      def input_format
        case @input.split('.').last
        when /^(md|markdown)$/
          "markdown"
        when /^(html|htm)/
          "html"
        else
          raise ArgumentError, "No format was given and format could not be parsed from the file name"
        end
      end

      def output_file
        output = @input_filename.dup
        output.gsub(/^(.+)\.[^.]*$/, "\\1.#{@output_fileformat}")
      end

  end
end