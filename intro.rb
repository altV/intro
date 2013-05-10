require 'pry-full'
require 'io/console'
require 'socket'
require 'active_support/all'

module Root
  extend self
  attr_accessor :socket

  def run
    self.socket = TCPServer.open(5000).accept
    loop do
      case @command = socket.readline[0..-2].tap {|e| p e}
      when '.poll'
        socket.puts Basic.current_text_grammar
      else
        puts "Context: #{@command}"
        #Basic.notify @command
        Basic.process @command
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
      'say  <dgndictation>' =>    ->(r) { `xte 'str #{words[1..-1].join(' ')}'` },
      'type <dgndictation>' =>    ->(r) {
        `xte 'str #{words[1..-1].join(' ')}'`
        `xte 'key Return' ')}'`
      }
    }

    Letters = {
      'Aff'    => ->(r) { `xte 'key A'` },
      'Brav'   => ->(r) { `xte 'key B'` },
      'Cai'    => ->(r) { `xte 'key C'` },
      'Doy'    => ->(r) { `xte 'key D'` },
      'Eck'    => ->(r) { `xte 'key E'` },
      'Fay'    => ->(r) { `xte 'key F'` },
      'Goff'   => ->(r) { `xte 'key G'` },
      'Hoop'   => ->(r) { `xte 'key H'` },
      'Ish'    => ->(r) { `xte 'key I'` },
      'Jo'     => ->(r) { `xte 'key J'` },
      'Keel'   => ->(r) { `xte 'key K'` },
      'Lee'    => ->(r) { `xte 'key L'` },
      'Mike'   => ->(r) { `xte 'key M'` },
      'Noy'    => ->(r) { `xte 'key N'` },
      'Osc'    => ->(r) { `xte 'key O'` },
      'Osh'    => ->(r) { `xte 'key O'` },
      'Pui'    => ->(r) { `xte 'key P'` },
      'Pom'    => ->(r) { `xte 'key P'` },
      'Quebec' => ->(r) { `xte 'key Q'` },
      'Queen'  => ->(r) { `xte 'key Q'` },
      'Ree'    => ->(r) { `xte 'key R'` },
      'Soi'    => ->(r) { `xte 'key S'` },
      'Tay'    => ->(r) { `xte 'key T'` },
      'Uni'    => ->(r) { `xte 'key U'` },
      'Umm'    => ->(r) { `xte 'key U'` },
      'Van'    => ->(r) { `xte 'key V'` },
      'Wes'    => ->(r) { `xte 'key W'` },
      'Xanth'  => ->(r) { `xte 'key X'` },
      'Yaa'    => ->(r) { `xte 'key Y'` },
      'Zul'    => ->(r) { `xte 'key Z'` },
      'a'      => ->(r) { `xte 'key a'` },
      'b'      => ->(r) { `xte 'key b'` },
      'c'      => ->(r) { `xte 'key c'` },
      'd'      => ->(r) { `xte 'key d'` },
      'e'      => ->(r) { `xte 'key e'` },
      'f'      => ->(r) { `xte 'key f'` },
      'g'      => ->(r) { `xte 'key g'` },
      'h'      => ->(r) { `xte 'key h'` },
      'i'      => ->(r) { `xte 'key i'` },
      'j'      => ->(r) { `xte 'key j'` },
      'k'      => ->(r) { `xte 'key k'` },
      'l'      => ->(r) { `xte 'key l'` },
      'm'      => ->(r) { `xte 'key m'` },
      'n'      => ->(r) { `xte 'key n'` },
      'o'      => ->(r) { `xte 'key o'` },
      'p'      => ->(r) { `xte 'key p'` },
      'q'      => ->(r) { `xte 'key q'` },
      'r'      => ->(r) { `xte 'key r'` },
      's'      => ->(r) { `xte 'key s'` },
      't'      => ->(r) { `xte 'key t'` },
      'u'      => ->(r) { `xte 'key u'` },
      'v'      => ->(r) { `xte 'key v'` },
      'w'      => ->(r) { `xte 'key w'` },
      'x'      => ->(r) { `xte 'key x'` },
      'y'      => ->(r) { `xte 'key y'` },
      'z'      => ->(r) { `xte 'key z'` },
      'pysh'   => ->(r) { `xte 'key Return'` }
    }

    Awesome = {
      'one'   => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][1])' },
      'two'   => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][2])' },
      'three' => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][3])' },
      'four'  => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][4])' },
      'five'  => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][5])' },
      'six'   => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][6])' },
      'seven' => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][7])' },
      'eight' => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][8])' },
      'nine'  => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][9])' },
      'nex'   => ->(r) { awesome 'awful.client.focus.byidx(1)'               },
      'prev'  => ->(r) { awesome 'awful.client.focus.byidx(-1)'              }
    }

    Programs = {
      'browser'  => ->(r) { `google-chrome` }
    }

    def current_text_grammar
      text_grammar *current_grammars
    end

    def current_grammars
      @current_grammars = [Letters, SayType, GnomeTerminal, Awesome]
    end

    def text_grammar *grammars
      "<dgndictation> imported; <main> exported = " +
        grammars.flat_map {|e| e.keys}.join(' | ') + ";"
    end

    def process command
      @current_grammars.each do |g|

      end
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
