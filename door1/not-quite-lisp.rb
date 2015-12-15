input = IO.binread('./quiz-input.txt').chomp
floor_input = input.each_char.map { |c| c == '(' ? 1 : -1 }
final_floor = floor_input.inject(0) { |sum, n| sum += n }
puts "Santa has to go to floor: #{final_floor}"
