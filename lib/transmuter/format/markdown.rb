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
        create_markdown.to_html
      end

      protected
        def parse_options(options)
          options = options.dup
          @options = options.merge!(:redcarpet_options => REDCARPET_OPTIONS)
        end

        def create_markdown
          Redcarpet.new(@markdown, *@options[:redcarpet_options])
        end
    end
  end
end