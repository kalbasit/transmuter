require 'redcloth'

module Transmuter
  module Format
    class Textile
      def initialize(textile, options = {})
        parse_options(options)
        @textile = textile
      end

      def to_pdf
        html = to_html
        pdf = Pdf.new(html, get_options)
        pdf.process
      end

      def to_html
        html = Html.new(parse_textile, get_options)
        html.process
      end

      protected
        def get_options
          @options.dup
        end

        def parse_options(options)
          @options = options.dup
        end

        def create_textile
          RedCloth.new(@textile)
        end

        def parse_textile
          create_textile.to_html
        end
    end
  end
end