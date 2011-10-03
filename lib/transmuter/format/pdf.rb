require 'pdfkit'

module Transmuter
  module Format
    class Pdf

      def initialize(html, options = {})
        parse_options(options)
        @html = html
      end

      def process
        kit = PDFKit.new(@html, :page_size => @options[:page_size])

        kit.to_pdf
      end

      protected
        def parse_options(options)
          options = options.dup
          @options = options.merge!(:page_size => 'Letter')
        end
    end
  end
end