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
