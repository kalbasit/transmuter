require 'active_support/core_ext'
require 'active_support/dependencies/autoload'

Dir["#{File.dirname(__FILE__)}/core_ext/**/*.rb"].each { |f| require f }