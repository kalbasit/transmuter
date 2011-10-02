module Transmuter
  module Format
    extend ::ActiveSupport::Autoload

    autoload :Markdown
    autoload :Html
    autoload :Pdf
  end
end