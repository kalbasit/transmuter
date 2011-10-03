require 'redcarpet'

module Transmuter
  module Format
    class Markdown
      REDCARPET_OPTIONS = [:autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]

      def initialize(markdown, options = {})
        parse_options(options)
        @markdown = markdown
      end

      def to_pdf
        html = to_html
        pdf = Pdf.new(html, get_options)
        pdf.process
      end

      def to_html
        html = Html.new(parse_markdown, get_options)
        html.process
      end

      protected
        def get_options
          options = @options.dup
          options.delete(:redcarpet_options)
          options
        end

        def parse_options(options)
          options = options.dup
          @options = options.merge!(:redcarpet_options => REDCARPET_OPTIONS)
        end

        def create_markdown
          Redcarpet.new(@markdown, *@options[:redcarpet_options])
        end

        def parse_markdown
          create_markdown.to_html
        end
    end
  end
end