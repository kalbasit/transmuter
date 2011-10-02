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

    argument :input,
      type: :string,
      required: true,
      aliases: "-i",
      desc: "The input file name."

    def set_input_filename
      @input_filename = input
    end

    def set_input_fileformat
      @input_fileformat = options[:input_format] || input_format
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

  end
end