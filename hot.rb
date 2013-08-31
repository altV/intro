require 'pry-full'
require 'io/console'
require 'socket'
require 'active_support/all'

ActiveSupport::Dependencies.autoload_paths += ["."]
def reload; ActiveSupport::Dependencies.clear end

Intro.run if __FILE__ == $0
