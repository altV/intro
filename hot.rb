require 'pry-full'
require 'io/console'
require 'socket'
require 'active_support/all'

ActiveSupport::Dependencies.autoload_paths += ["."]
def reload!; ActiveSupport::Dependencies.clear end
def r; ActiveSupport::Dependencies.clear end

loop do
  begin
    break if $shutdown_this
    Intro.run
  rescue SyntaxError, Errno::ENOENT => e
    p e
    sleep 2
    retry
  end
end if __FILE__ == $0
