input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp
floor_input = input.each_char.map { |c| c == '(' ? 1 : -1 }
index = 1
floor_input.inject(0) do |sum, num|
  break if sum + num < 0
  index += 1
  sum + num
end
puts "Santa just stepped into the cellar at: #{index}"
