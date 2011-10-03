require 'albino'
require 'nokogiri'

module Transmuter
  module Format
    class Html

      def initialize(html, options = {})
        parse_options(options)
        @html = html
      end

      def process
        include_inline_stylesheets(syntax_highlighter)
      end

      protected
        def get_options
          options = @options.dup
          options.delete(:redcarpet_options)
          options
        end

        def parse_options(options)
          @options = options.dup
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
            head = doc.xpath('/html/head').first

            style = Nokogiri::XML::Node.new "style", doc
            style['type'] = "text/css"
            style.content = stylesheet_contents

            unless head.present?
              head = Nokogiri::XML::Node.new "head", doc
              body = doc.xpath('/html/body').first
              body.add_previous_sibling head
            end

            style.parent = head

            html = doc.to_s
          end

          html
        end

        def syntax_highlighter
          doc = Nokogiri::HTML(@html)
          doc.search("//pre[@lang]").each do |pre|
            pre.replace Albino.colorize(pre.text.rstrip, pre[:lang].downcase.to_sym)
          end
          doc.to_s
        end
    end
  end
end