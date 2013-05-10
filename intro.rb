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
      p @context
      @command = @context.map{|e| e[:char]}.join
      @command = @command.split(' ').map(&:downcase).join(' ')
      @command = @command[-1] if @command[0] == "\x7F"
      @context = []
      puts "Context: #{@command}"
      #Basic.notify @command
      Basic.process @command
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
      'say  <dgndictation>' =>    ->(r) { `xte 'key A'` },
      'type <dgndictation>' =>    ->(r) { `xte 'key A'` }
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
      'nine'  => ->(r) { awesome 'awful.tag.viewonly(tags[mouse.screen][9])' }
    }

    def current_text_grammar
      text_grammar Letters, SayType, GnomeTerminal
    end

    def text_grammar *grammars
      "<main> exported = " + grammars.flat_map {|e| e.keys}.join(' | ')
    end

    def process command
      words = command.split(' ')
      case command
      when 'browser' then `google-chrome`
      when /^ruby .+/
        begin
          eval "#{words[1]} '#{words[2..-1].join(' ')}'"
        rescue Exception => e
          p e
        end
      when /^say .+/        then `xte 'str #{words[1..-1].join(' ')}'`
      when /^phrase .+/
        `xte 'str #{words[1..-1].join(' ')}'`
        `xte 'key Return' ')}'`


      when 'right' then `xte 'mousermove 50 0'`
      when 'left'  then `xte 'mousermove -50 0'`
      when 'down'  then `xte 'mousermove 0 50'`
      when 'up'    then `xte 'mousermove 0 -50'`
      when 'click' then `xte 'mouseclick 1'`
      else
        puts "no command #{@command}"
      end
    rescue StandardError => e
      p e
    end

    def notify message; `notify-send "Dragon" "#{message.gsub!('"','\"')}"`               end
    def say    message; `echo "#{message.gsub!('"','\"')}" | espeak`                      end
  end

  module Sys
    extend self
    def awesome     str; `echo "return #{str}" | awesome-client`                          end
    def awesome_say str; `echo "return #{str.gsub!('"','\"')}" | awesome-client | espeak` end
  end
  extend Sys
end


Root.run if __FILE__ == $_
puts 'Ready.'
#system 'stty -raw echo'
