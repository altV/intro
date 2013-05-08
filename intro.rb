require 'pry-full'
require 'io/console'
require 'active_support/all'

module Root
  extend self

  def partial_from_stdin
    blk = ->{
      r = select [STDIN],[],[],0.2
      return ['', Time.now] unless r
      result = STDIN.read_nonblock 200
      [result, Time.now]}
    if STDIN.tty?
      STDIN.raw { blk[] }
    else
      blk[]
    end
  end

  def add_to_context char
    if char == '' && @context.size > 1 && @context[-2][:char] == ''
      @context[-1][:time] = Time.now
    else
      @context << {char: char, time: Time.now}
    end
  end

  def run
    @context = []
    $mtime = File.mtime('intro.rb')
    loop do
      break if File.mtime('intro.rb') - $mtime != 0
      add_to_context partial_from_stdin[0]
      if @context.size > 1 &&
          (@context[-1][:time] - @context[-2][:time] > 0.05.seconds) &&
          @context.map{|e| e[:char]}.join != ''
        system 'clear'
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
  end

  module Basic
    extend self

    Letters = {
      'Aff':    -> { `xte 'key A'` },
      'Brav':   -> { `xte 'key B'` },
      'Cai':    -> { `xte 'key C'` },
      'Doy':    -> { `xte 'key D'` },
      'Eck':    -> { `xte 'key E'` },
      'Fay':    -> { `xte 'key F'` },
      'Goff':   -> { `xte 'key G'` },
      'Hoop':   -> { `xte 'key H'` },
      'Ish':    -> { `xte 'key I'` },
      'Jo':     -> { `xte 'key J'` },
      'Keel':   -> { `xte 'key K'` },
      'Lee':    -> { `xte 'key L'` },
      'Mike':   -> { `xte 'key M'` },
      'Noy':    -> { `xte 'key N'` },
      'Osc':    -> { `xte 'key O'` },
      'Osh':    -> { `xte 'key O'` },
      'Pui':    -> { `xte 'key P'` },
      'Pom':    -> { `xte 'key P'` },
      'Quebec': -> { `xte 'key Q'` },
      'Queen':  -> { `xte 'key Q'` },
      'Ree':    -> { `xte 'key R'` },
      'Soi':    -> { `xte 'key S'` },
      'Tay':    -> { `xte 'key T'` },
      'Uni':    -> { `xte 'key U'` },
      'Umm':    -> { `xte 'key U'` },
      'Van':    -> { `xte 'key V'` },
      'Wes':    -> { `xte 'key W'` },
      'Xanth':  -> { `xte 'key X'` },
      'Yaa':    -> { `xte 'key Y'` },
      'Zul':    -> { `xte 'key Z'` },
      'a':      -> { `xte 'key a'` },
      'b':      -> { `xte 'key b'` },
      'c':      -> { `xte 'key c'` },
      'd':      -> { `xte 'key d'` },
      'e':      -> { `xte 'key e'` },
      'f':      -> { `xte 'key f'` },
      'g':      -> { `xte 'key g'` },
      'h':      -> { `xte 'key h'` },
      'i':      -> { `xte 'key i'` },
      'j':      -> { `xte 'key j'` },
      'k':      -> { `xte 'key k'` },
      'l':      -> { `xte 'key l'` },
      'm':      -> { `xte 'key m'` },
      'n':      -> { `xte 'key n'` },
      'o':      -> { `xte 'key o'` },
      'p':      -> { `xte 'key p'` },
      'q':      -> { `xte 'key q'` },
      'r':      -> { `xte 'key r'` },
      's':      -> { `xte 'key s'` },
      't':      -> { `xte 'key t'` },
      'u':      -> { `xte 'key u'` },
      'v':      -> { `xte 'key v'` },
      'w':      -> { `xte 'key w'` },
      'x':      -> { `xte 'key x'` },
      'y':      -> { `xte 'key y'` },
      'z':      -> { `xte 'key z'` }
    }

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


      when 'enter'          then `xte 'key Return'`

      when 'one','1'   then awesome 'awful.tag.viewonly(tags[mouse.screen][1])'
      when 'two','2'   then awesome 'awful.tag.viewonly(tags[mouse.screen][2])'
      when 'three','3' then awesome 'awful.tag.viewonly(tags[mouse.screen][3])'
      when 'four','4'  then awesome 'awful.tag.viewonly(tags[mouse.screen][4])'
      when 'five','5'  then awesome 'awful.tag.viewonly(tags[mouse.screen][5])'
      when 'six','6'   then awesome 'awful.tag.viewonly(tags[mouse.screen][6])'
      when 'seven','7' then awesome 'awful.tag.viewonly(tags[mouse.screen][7])'
      when 'eight','8' then awesome 'awful.tag.viewonly(tags[mouse.screen][8])'
      when 'nine','9'  then awesome 'awful.tag.viewonly(tags[mouse.screen][9])'

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

    def awesome     str; `echo "return #{str}" | awesome-client`                          end
    def awesome_say str; `echo "return #{str.gsub!('"','\"')}" | awesome-client | espeak` end

    def notify message; `notify-send "Dragon" "#{message.gsub!('"','\"')}"`               end
    def say    message; `echo "#{message.gsub!('"','\"')}" | espeak`                      end
  end
end


puts 'Ready.'
Root.run
#system 'stty -raw echo'
