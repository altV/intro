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
          (@context[-1][:time] - @context[-2][:time] > 0.5.seconds) &&
          @context.map{|e| e[:char]}.join != ''
        @command = @context.map{|e| e[:char]}.join
        @command = @command.split(' ').map(&:downcase).join(' ')
        @context = []
        puts "Context: #{@command}"
        ($ninja=1; break) if @command == 'ninja'
        begin
          case
          when c=Basic::Table[@command]
            c.call
          else
            puts "no command #{@command}"
          end
        #rescue StandardError => e
          #puts "Hey, i have no command #{e}, care to voice-input?"
        end
      end
    end
  end

  module Basic
    extend self
    Table={
      'greetings' => ->{`notify-send 'asdf wqer'`},
      'greetings' => ->{`google-chrome`},
      'greet'     => ->{p "notify-send 'ohaaaaaaai!'"},
      'greet me'  => ->{`notify-send ohaaaaaaai`}
    }
    def sys_notify message
      `notify-send #{message}`
    end
  end

end


puts 'Ready.'
Root.run
#Root.run if __FILE__ == $0
#system 'stty -raw echo'
