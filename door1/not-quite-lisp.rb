input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp
floor_input = input.each_char.map { |c| c == '(' ? 1 : -1 }
final_floor = floor_input.inject(0) { |sum, n| sum += n }
puts "Santa has to go to floor: #{final_floor}"
