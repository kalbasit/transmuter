module Transmuter
  module Format
    extend ::ActiveSupport::Autoload

    autoload :Markdown
    autoload :Textile
    autoload :Html
    autoload :Pdf
  end
end