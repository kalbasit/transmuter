require 'thor'
require 'thor/group'

module Transmuter
  class CLI < Thor::Group
    desc "Transmute one file format into another"

    argument :input,
      type: :string,
      required: true,
      aliases: "-i",
      desc: "The input file name."

  end
end