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

      when 'Aff'            then `xte 'key a'`
      when 'Brav'           then `xte 'key a'`
      when 'Cai'            then `xte 'key a'`
      when 'Doy'            then `xte 'key a'`
      when 'Eck'            then `xte 'key a'`
      when 'Fay'            then `xte 'key a'`
      when 'Goff'           then `xte 'key a'`
      when 'Hoop'           then `xte 'key a'`
      when 'Ish'            then `xte 'key a'`
      when 'Jo'             then `xte 'key a'`
      when 'Keel'           then `xte 'key a'`
      when 'Lee'            then `xte 'key a'`
      when 'Mike'           then `xte 'key a'`
      when 'Noy'            then `xte 'key a'`
      when 'Osc','Osh'      then `xte 'key a'`
      when 'Pui','Pom'      then `xte 'key a'`
      when 'Quebec','Queen' then `xte 'key a'`
      when 'Ree'            then `xte 'key a'`
      when 'Soi'            then `xte 'key a'`
      when 'Tay'            then `xte 'key a'`
      when 'Uni','Umm'      then `xte 'key a'`
      when 'Van'            then `xte 'key a'`
      when 'Wes'            then `xte 'key a'`
      when 'Xanth'          then `xte 'key a'`
      when 'Yaa'            then `xte 'key a'`
      when 'Zul'            then `xte 'key a'`
      when 'ash'            then `xte 'key a'`
      when 'ash'            then `xte 'key b'`
      when 'ash'            then `xte 'key c'`
      when 'ash'            then `xte 'key d'`
      when 'ash'            then `xte 'key e'`
      when 'ash'            then `xte 'key f'`
      when 'ash'            then `xte 'key g'`
      when 'ash'            then `xte 'key h'`
      when 'ash'            then `xte 'key i'`
      when 'ash'            then `xte 'key j'`
      when 'ash'            then `xte 'key k'`
      when 'ash'            then `xte 'key l'`
      when 'ash'            then `xte 'key m'`
      when 'ash'            then `xte 'key n'`
      when 'ash'            then `xte 'key o'`
      when 'ash'            then `xte 'key p'`
      when 'ash'            then `xte 'key q'`
      when 'ash'            then `xte 'key r'`
      when 'ash'            then `xte 'key s'`
      when 'ash'            then `xte 'key t'`
      when 'ash'            then `xte 'key u'`
      when 'ash'            then `xte 'key v'`
      when 'ash'            then `xte 'key w'`
      when 'ash'            then `xte 'key x'`
      when 'ash'            then `xte 'key y'`
      when 'ash'            then `xte 'key z'`

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
