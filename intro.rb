module Intro
  extend self
  Letters = Grammar::Letters
  SayType = Grammar::SayType
  GnomeTerminal = Grammar::GnomeTerminal
  Awesome = Grammar::Awesome

  def run
    $socket ||= TCPServer.open(5000).accept
    loop do
      case command = $socket.readline[0..-2].tap {|e| p e}
      when '.poll'
        $socket.puts current_text_grammar
      else
        puts "Received: #{command}"
        words = eval(command).map {|e| e.gsub(/\\.*/,'')}
        #notify command
        process words
      end
    end
  end

  def current_state # not actually needed, and a bad knowledge. to be called from particular grammars
    {client_type:      awesome('client.focus.class'    )[ 11..-3],
     client_pid:       awesome('client.focus.pid'      )[ 11..-3],
     client_name:      awesome('client.focus.name'     )[ 11..-3]   }
  end


  def current_text_grammar
    text_grammar *current_grammars
  end

  def current_grammars
    [Letters, SayType, GnomeTerminal, Awesome]
  end

  def text_grammar *grammars
    "<dgnletters> imported; <dgnwords> imported; <dgndictation> imported; " +
      "<main> exported = (" + grammars.flat_map {|e| e.keys}.join(' | ') + ")+;"
  end

  def process words
    grammars_kv = @current_grammars.flat_map {|e| e.to_a}

    grammars_kv.
      each {|e| e[1].call(words) if e[0] == words.join(' ') && e[0].split(' ').size == 2 }

    grammars_kv.
      each {|e| gram_words = e[0].split(' ');
            e[1].call(words) if gram_words.size == 2 &&
              gram_words[1][0] == '<' && gram_words[0] == words[0] && p("got #{e}")}

    words.each {|word| grammars_kv.
                          each {|e| e[1].call(words) if e[0] == word }
    }

  rescue StandardError => e
    p e
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
