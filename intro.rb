module Intro
  extend self
  class ItsReloadTime < StandardError; end

  Reloader = ActiveSupport::FileUpdateChecker.new(Dir["**/**"]) do
    ActiveSupport::Dependencies.clear
    raise ItsReloadTime
  end

  def run
    $socket ||= TCPServer.open(5000).accept
    loop do
      case command = $socket.readline[0..-2].tap {|e| p e}
      when '.poll'
        $socket.puts grammars_in_gragon
      else
        puts "Received: #{command}"
        p words = eval(command.gsub('(','[').gsub(')',']')).
          tap {|words_with_grammars| words_with_grammars.each {|e| e[0].gsub!(/\\.*/,'')}}
        #notify command
        Grammar.process words
      end
      Reloader.execute_if_updated
    end
  rescue ItsReloadTime
  end

  def current_state # not actually needed, and a bad knowledge. to be called from particular grammars
    {client_type:      awesome('client.focus.class'    )[ 11..-3],
     client_pid:       awesome('client.focus.pid'      )[ 11..-3],
     client_name:      awesome('client.focus.name'     )[ 11..-3]   }
  end


  def grammars_in_gragon *grammars
    grammars = grammars.presence || current_grammars
    "<dgnletters> imported; <dgnwords> imported; <dgndictation> imported; " +
      current_grammars.join(" ") +
      "<main> exported = (" + grammars.map {|e| "<#{e.name}>"}.join(' | ') + ")+;"
  end

  def current_grammars
    [Grammar::Letters, Grammar::SayType, Grammar::Programs, Grammar::Awesome] #Grammar::GnomeTerminal
  end

  module Sys
    extend self
    def awesome     str; `echo "return #{str}" | awesome-client`                          end
    def awesome_say str; `echo "return #{str.gsub!('"','\"')}" | awesome-client | espeak` end
    def notify message; `notify-send "Dragon" "#{message.gsub!('"','\"')}"`               end
    def say    message; `echo "#{message.gsub!('"','\"')}" | espeak`                      end
  end
  extend Sys
end


Intro.run if __FILE__ == $0
puts 'Ready.'
#system 'stty -raw echo'
