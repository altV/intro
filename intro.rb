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
        `xte 'key Return'`
      }
    }

    Letters = {
      'apple'   => ->(w) { `xte 'str A'` },
      'ash'     => ->(w) { `xte 'str a'` },
      'boom'    => ->(w) { `xte 'str B'` },
      'big'     => ->(w) { `xte 'str b'` },
      'cook'    => ->(w) { `xte 'str C'` },
      'cat'     => ->(w) { `xte 'str c'` },
      'dim'     => ->(w) { `xte 'str D'` },
      'dog'     => ->(w) { `xte 'str d'` },
      'easy'    => ->(w) { `xte 'str E'` },
      'egg'     => ->(w) { `xte 'str e'` },
      'Fay'     => ->(w) { `xte 'str F'` },
      'far'     => ->(w) { `xte 'str f'` },
      'Goff'    => ->(w) { `xte 'str G'` },
      'gim'     => ->(w) { `xte 'str g'` },
      'Hoop'    => ->(w) { `xte 'str H'` },
      'her'     => ->(w) { `xte 'str h'` },
      'Ike'     => ->(w) { `xte 'str I'` },
      'is'      => ->(w) { `xte 'str i'` },
      'Joe'     => ->(w) { `xte 'str J'` },
      'jim'     => ->(w) { `xte 'str j'` },
      'Keel'    => ->(w) { `xte 'str K'` },
      'cai'     => ->(w) { `xte 'str k'` },
      'Lee'     => ->(w) { `xte 'str L'` },
      'lick'    => ->(w) { `xte 'str l'` },
      'Mike'    => ->(w) { `xte 'str M'` },
      'moon'    => ->(w) { `xte 'str m'` },
      'Noy'     => ->(w) { `xte 'str N'` },
      'nor'     => ->(w) { `xte 'str n'` },
      'Osc'     => ->(w) { `xte 'str O'` },
      'Osh'     => ->(w) { `xte 'str o'` },
      'Pui'     => ->(w) { `xte 'str P'` },
      'pom'     => ->(w) { `xte 'str p'` },
      #'Quebec' => ->(w) { `xte 'str Q'` },
      'Queen'   => ->(w) { `xte 'str Q'` },
      'queue'   => ->(w) { `xte 'str q'` },
      'Roy'     => ->(w) { `xte 'str R'` },
      'ree'     => ->(w) { `xte 'str r'` },
      'Soi'     => ->(w) { `xte 'str S'` },
      'see'     => ->(w) { `xte 'str s'` },
      'Tay'     => ->(w) { `xte 'str T'` },
      'tea'     => ->(w) { `xte 'str t'` },
      #'Uni'    => ->(w) { `xte 'str U'` },
      'Umm'     => ->(w) { `xte 'str U'` },
      'you'     => ->(w) { `xte 'str u'` },
      'Van'     => ->(w) { `xte 'str V'` },
      'vim'     => ->(w) { `xte 'str v'` },
      'Woop'    => ->(w) { `xte 'str W'` },
      'wes'     => ->(w) { `xte 'str w'` },
      'Xor'   => ->(w) { `xte 'str X'` },
      'ex'      => ->(w) { `xte 'str x'` },
      'Yaa'     => ->(w) { `xte 'str Y'` },
      'why'     => ->(w) { `xte 'str y'` },
      'Zul'     => ->(w) { `xte 'str Z'` },
      'zee'     => ->(w) { `xte 'str z'` },

      'pysh'    => ->(w) { `xte 'key Return'` },
      'never'   => ->(w) { `xte 'key Escape'` },
      'quote'   => ->(w) { `xte "str '"` },
      'never'   => ->(w) { `xte 'str "'` },

      'one'   => ->(w) { `xte 'str 1'` },
      'two'   => ->(w) { `xte 'str 2'` },
      'three' => ->(w) { `xte 'str 3'` },
      'four'  => ->(w) { `xte 'str 4'` },
      'five'  => ->(w) { `xte 'str 5'` },
      'six'   => ->(w) { `xte 'str 6'` },
      'seven' => ->(w) { `xte 'str 7'` },
      'eight' => ->(w) { `xte 'str 8'` },
      'nine'  => ->(w) { `xte 'str 9'` },
      'zero'  => ->(w) { `xte 'str 0'` }
    }

    Awesome = {
      'at one'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][1])' },
      'at two'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][2])' },
      'at three' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][3])' },
      'at four'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][4])' },
      'at five'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][5])' },
      'at six'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][6])' },
      'at seven' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][7])' },
      'at eight' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][8])' },
      'at nine'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][9])' },
      'at next'   => ->(w) { awesome 'awful.client.focus.byidx(1)'               },
      'at prev'  => ->(w) { awesome 'awful.client.focus.byidx(-1)'              }
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
