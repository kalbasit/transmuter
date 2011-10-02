require 'thor'
require 'thor/group'

module Transmuter
  class CLI < Thor::Group
    desc "Transmute one file format into another"
  end
end