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
      when '.grammar'
        $socket.puts grammars_in_gragon
      when '.poll'
        @msg ||= ""
        $socket.puts msg
      else
        puts "Received: #{command}"
        p words = eval(command.gsub('(','[').gsub(')',']')).
          tap {|words_with_grammars| words_with_grammars.each {|e| e[0].gsub!(/\\.*/,'')}}
        notify words.map {|e| e[0]}.join(' ')
        Grammar.process words
      end
      Reloader.execute_if_updated
    end
  rescue ItsReloadTime
  rescue EOFError
    puts '-------> Disconnected <------'
    $socket = nil
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
    [Grammar::Letters,
     Grammar::SayType,
     Grammar::Vim,
     Grammar::Main,
     Grammar::Programs,
     Grammar::Awesome] #Grammar::GnomeTerminal
  end

  def dragon_eval cmd
    @msg ||= ""
    @msg << cmd << ";"
  end

  module Sys
    extend self
    def awesome     str; `echo "return #{str}" | awesome-client`                          end
    def awesome_say str; `echo "return #{str.gsub!('"','\"')}" | awesome-client | espeak` end
    def notify message, time = 3_000
      `notify-send -t #{time} "Dragon" "#{message.lines.flat_map {|e| e.scan(/.{1,120}/) }.join("\n").shellescape}"`
    end
    def say    message; `echo "#{message.gsub!('"','\"')}" | espeak`                      end
  end
  extend Sys

  module Dragon
    extend self
    def update_grammar ; Intro.dragon_eval "updateGrammarFromClient()"       end
    def mic_on         ; Intro.dragon_eval 'natlink.setMicState("on")'       end
    def mic_off        ; Intro.dragon_eval 'natlink.setMicState("off")'      end
    def mic_sleep      ; Intro.dragon_eval 'natlink.setMicState("sleeping")' end
    def exit_dragon    ; Intro.dragon_eval "break"                           end
  end
end


Intro.run if __FILE__ == $0
puts '-------> Loaded <-------'
#system 'stty -raw echo'
