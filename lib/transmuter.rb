ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))

# Taken from hub
# https://github.com/defunkt/hub/blob/master/lib/hub/context.rb#L186
# Cross-platform way of finding an executable in the $PATH.
#
# which('ruby') #=> /usr/bin/ruby
def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = "#{path}/#{cmd}#{ext}"
      return exe if File.executable? exe
    }
  end
  return nil
end

require "active_support/json"
require "active_support/dependencies/autoload"
require "active_support/core_ext"
require "transmuter/version"
require "transmuter/format"
require "transmuter/cli"
