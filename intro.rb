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
        ($ninja=1; break) if @command == 'ninja'
      end
    end
  end

  module Basic
    extend self

    def process command
      case command
      when 'browser' then `google-chrome`
      when 'greet'   then `notify-send ohaaaaaaai`

      when 'ash'   then `xte 'key a'`
      when 'ash'   then `xte 'key b'`
      when 'ash'   then `xte 'key c'`
      when 'ash'   then `xte 'key d'`
      when 'ash'   then `xte 'key e'`
      when 'ash'   then `xte 'key f'`
      when 'ash'   then `xte 'key g'`
      when 'ash'   then `xte 'key h'`
      when 'ash'   then `xte 'key i'`
      when 'ash'   then `xte 'key j'`
      when 'ash'   then `xte 'key k'`
      when 'ash'   then `xte 'key l'`
      when 'ash'   then `xte 'key m'`
      when 'ash'   then `xte 'key n'`
      when 'ash'   then `xte 'key o'`
      when 'ash'   then `xte 'key p'`
      when 'ash'   then `xte 'key q'`
      when 'ash'   then `xte 'key r'`
      when 'ash'   then `xte 'key s'`
      when 'ash'   then `xte 'key t'`
      when 'ash'   then `xte 'key u'`
      when 'ash'   then `xte 'key v'`
      when 'ash'   then `xte 'key w'`
      when 'ash'   then `xte 'key x'`
      when 'ash'   then `xte 'key y'`
      when 'ash'   then `xte 'key z'`
      when 'one'   then `echo 'awful.tag.viewonly(tags[mouse.screen][1])' | awesome-client`
      when '1'   then `echo 'awful.tag.viewonly(tags[mouse.screen][1])' | awesome-client`
      when 'two'   then `echo 'awful.tag.viewonly(tags[mouse.screen][2])' | awesome-client`
      when '2'   then `echo 'awful.tag.viewonly(tags[mouse.screen][2])' | awesome-client`
      when 'three'   then `echo 'awful.tag.viewonly(tags[mouse.screen][3])' | awesome-client`
      when '3'   then `echo 'awful.tag.viewonly(tags[mouse.screen][3])' | awesome-client`
      when 'seven'   then `echo 'awful.tag.viewonly(tags[mouse.screen][7])' | awesome-client`
      when '7'   then `echo 'awful.tag.viewonly(tags[mouse.screen][7])' | awesome-client`
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

    def sys_notify message
      `notify-send #{message}`
    end
  end
end


puts 'Ready.'
Root.run
#system 'stty -raw echo'
