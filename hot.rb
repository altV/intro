puts 'Awaiting connection on 5000'
$socket ||= TCPServer.open(5000).accept
loop do
  break if $ninja
  puts "Reloading"
  begin
    load 'intro.rb', true
  rescue SyntaxError, Errno::ENOENT => e
    p e
    sleep 1
    retry
  end
end
