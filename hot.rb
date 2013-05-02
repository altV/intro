loop do
  break if $ninja
  puts "Reloading"
  begin
    load 'intro.rb', true
  end
end
