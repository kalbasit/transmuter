require 'transmuter/cli/thor'
require 'transmuter/cli/execute'
require 'transmuter/cli/help'

module Transmuter
  module CLI
    class Runner < ::Thor::Group
      include Thor
      include Execute
      include Help
    end
  end
end