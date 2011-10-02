require 'redcarpet'
require 'albino'
require 'nokogiri'

module Transmuter
  module Format
    class Markdown
      REDCARPET_OPTIONS = [:autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]

      def initialize(markdown, options = {})
        parse_options(options)
        @markdown = markdown
      end

      def to_html
        include_inline_stylesheets syntax_highlighter(parse_markdown)
      end

      protected
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

        def read_stylesheet_files
          case @options[:stylesheets]
          when Array
            @options[:stylesheets].collect do |f|
              File.read(f)
            end.join("\n")
          when String
            File.read @options[:stylesheets]
          when NilClass
            # Apparently no stylesheets has been requested
          end
        end

        def include_inline_stylesheets(html)
          if @options[:stylesheets].present?
            stylesheet_contents = read_stylesheet_files

            doc = Nokogiri::HTML(html)
            body = doc.xpath('/html/body').first
            head = Nokogiri::XML::Node.new "head", doc
            style = Nokogiri::XML::Node.new "style", doc
            style['type'] = "text/css"
            style.content = stylesheet_contents
            style.parent = head

            body.add_previous_sibling head
            html = doc.to_s
          end

          html
        end

        def syntax_highlighter(html)
          doc = Nokogiri::HTML(html)
          doc.search("//pre[@lang]").each do |pre|
            pre.replace Albino.colorize(pre.text.rstrip, pre[:lang].downcase.to_sym)
          end
          doc.to_s
        end
    end
  end
end