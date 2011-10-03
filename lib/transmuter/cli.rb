require 'transmuter/cli/thor'
require 'transmuter/cli/transmute'
require 'transmuter/cli/help'

module Transmuter
  module CLI
    class Runner < ::Thor::Group
      DEFAULT_THEME = File.expand_path(File.join(ROOT_PATH, 'stylesheets', 'default.css'))

      include Transmute
      include Help
      include Thor
    end
  end
end