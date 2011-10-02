require 'transmuter/cli/thor'
require 'transmuter/cli/transmute'
require 'transmuter/cli/help'

module Transmuter
  module CLI
    class Runner < ::Thor::Group
      include Transmute
      include Help
      include Thor
    end
  end
end