require 'pry-full'
require 'io/console'
require 'socket'
require 'active_support/all'

module Root
  extend self

  def run
    $socket ||= TCPServer.open(5000).accept
    loop do
      case command = $socket.readline[0..-2].tap {|e| p e}
      when '.poll'
        $socket.puts Basic.current_text_grammar
      else
        puts "Received: #{command}"
        words = eval(command).map {|e| e.gsub(/\\.*/,'')}
        #Basic.notify command
        Basic.process words
      end
    end
  end

  def current_state # not actually needed, and a bad knowledge. to be called from particular grammars
    {client_type:      awesome('client.focus.class'    )[ 11..-3],
     client_pid:       awesome('client.focus.pid'      )[ 11..-3],
     client_name:      awesome('client.focus.name'     )[ 11..-3]   }
  end

  module Basic
    extend self

    GnomeTerminal = {
    }

    SayType = {
      'say  <dgndictation>' =>    ->(w) { `xte 'str #{w[1..-1].join(' ')}'` },
      'word <dgnwords>'     =>    ->(w) { `xte 'str #{w[1..-1].join(' ')}'` },
      'let  <dgnletters>'   =>    ->(w) { `xte 'str #{w[1..-1].join(' ')}'` },
      'type <dgndictation>' =>    ->(w) {
        `xte 'str #{w[1..-1].join(' ')}'`
        `xte 'key Return' ')}'`
      }
    }

    Letters = {
      'Aff'    => ->(w) { `xte 'key A'` },
      'Brav'   => ->(w) { `xte 'key B'` },
      'Cai'    => ->(w) { `xte 'key C'` },
      'Doy'    => ->(w) { `xte 'key D'` },
      'Eck'    => ->(w) { `xte 'key E'` },
      'Fay'    => ->(w) { `xte 'key F'` },
      'Goff'   => ->(w) { `xte 'key G'` },
      'Hoop'   => ->(w) { `xte 'key H'` },
      'Ish'    => ->(w) { `xte 'key I'` },
      'Jo'     => ->(w) { `xte 'key J'` },
      'Keel'   => ->(w) { `xte 'key K'` },
      'Lee'    => ->(w) { `xte 'key L'` },
      'Mike'   => ->(w) { `xte 'key M'` },
      'Noy'    => ->(w) { `xte 'key N'` },
      'Osc'    => ->(w) { `xte 'key O'` },
      'Osh'    => ->(w) { `xte 'key O'` },
      'Pui'    => ->(w) { `xte 'key P'` },
      'Pom'    => ->(w) { `xte 'key P'` },
      'Quebec' => ->(w) { `xte 'key Q'` },
      'Queen'  => ->(w) { `xte 'key Q'` },
      'Ree'    => ->(w) { `xte 'key R'` },
      'Soi'    => ->(w) { `xte 'key S'` },
      'Tay'    => ->(w) { `xte 'key T'` },
      'Uni'    => ->(w) { `xte 'key U'` },
      'Umm'    => ->(w) { `xte 'key U'` },
      'Van'    => ->(w) { `xte 'key V'` },
      'Wes'    => ->(w) { `xte 'key W'` },
      'Xanth'  => ->(w) { `xte 'key X'` },
      'Yaa'    => ->(w) { `xte 'key Y'` },
      'Zul'    => ->(w) { `xte 'key Z'` },
      'a'      => ->(w) { `xte 'key a'` },
      'b'      => ->(w) { `xte 'key b'` },
      'c'      => ->(w) { `xte 'key c'` },
      'di'      => ->(w) { `xte 'key d'` },
      'em'      => ->(w) { `xte 'key e'` },
      'for'      => ->(w) { `xte 'key f'` },
      'gim'      => ->(w) { `xte 'key g'` },
      'him'      => ->(w) { `xte 'key h'` },
      'ees'      => ->(w) { `xte 'key i'` },
      'jim'      => ->(w) { `xte 'key j'` },
      'k'      => ->(w) { `xte 'key k'` },
      'l'      => ->(w) { `xte 'key l'` },
      'm'      => ->(w) { `xte 'key m'` },
      'n'      => ->(w) { `xte 'key n'` },
      'o'      => ->(w) { `xte 'key o'` },
      'p'      => ->(w) { `xte 'key p'` },
      'q'      => ->(w) { `xte 'key q'` },
      'r'      => ->(w) { `xte 'key r'` },
      's'      => ->(w) { `xte 'key s'` },
      't'      => ->(w) { `xte 'key t'` },
      'u'      => ->(w) { `xte 'key u'` },
      'v'      => ->(w) { `xte 'key v'` },
      'w'      => ->(w) { `xte 'key w'` },
      'x'      => ->(w) { `xte 'key x'` },
      'y'      => ->(w) { `xte 'key y'` },
      'z'      => ->(w) { `xte 'key z'` },
      'pysh'   => ->(w) { `xte 'key Return'` }
    }

    Awesome = {
      'a one'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][1])' },
      'a two'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][2])' },
      'a three' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][3])' },
      'a four'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][4])' },
      'a five'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][5])' },
      'a six'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][6])' },
      'a seven' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][7])' },
      'a eight' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][8])' },
      'a nine'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][9])' },
      'a nex'   => ->(w) { awesome 'awful.client.focus.byidx(1)'               },
      'a prev'  => ->(w) { awesome 'awful.client.focus.byidx(-1)'              }
    }

    Programs = {
      'launch browser' => ->(w) { `google-chrome` },
      'launch gedit'   => ->(w) { `gedit` }
    }

    def current_text_grammar
      text_grammar *current_grammars
    end

    def current_grammars
      @current_grammars = [Letters, SayType, GnomeTerminal, Awesome]
    end

    def text_grammar *grammars
      "<dgnletters> imported; <dgnwords> imported; <dgndictation> imported; " +
        "<main> exported = " + grammars.flat_map {|e| e.keys}.join(' | ') + ";"
    end

    def process words
      @current_grammars.flat_map {|e| e.to_a}.
        each {|e| e[1].call(words) if e[0] == words.join(' ') }

      @current_grammars.flat_map {|e| e.to_a}.
        each {|e| gram_words = e[0].split(' ');
              e[1].call(words) if gram_words .size == 2 &&
              gram_words[1][0] == '<' && gram_words[0] == words[0] && p("got #{e}")}
    rescue StandardError => e
      p e
    end

  end

  module Sys
    extend self
    def awesome     str; `echo "return #{str}" | awesome-client`                          end
    def awesome_say str; `echo "return #{str.gsub!('"','\"')}" | awesome-client | espeak` end
    def notify message; `notify-send "Dragon" "#{message.gsub!('"','\"')}"`               end
    def say    message; `echo "#{message.gsub!('"','\"')}" | espeak`                      end
  end
  extend Sys
  Root::Basic.extend Sys
end


Root.run if __FILE__ == $0
puts 'Ready.'
#system 'stty -raw echo'
