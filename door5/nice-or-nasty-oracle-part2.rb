input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class NicenessChecker
  attr_accessor :input

  def initialize(input)
    @input = input.chomp
  end

  def is_nice?
  end

  def twice_appearing_letter_pair?
    @input.each_char.each_with_index do |char, index|
      @input[0
    end
  end

  def contains_letter_appearing_twice_in_a_row?
    return false if @input.length < 2
    chars = @input.each_char
    next_char = ''
    loop do
      current_char = chars.next
      return true if current_char == next_char
      next_char = chars.next
      return true if current_char == next_char
    end
    return false
  rescue StopIteration
    false
  end
end

class NicenessCheckerMachine
  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def nice_count
    @input.each_line.map { |line| NicenessChecker.new(line).is_nice? }.count { |x| x }
  end
end

sample1 = 'ugknbfddgicrmopn'
is_nice1 = true

sample2 = 'aaa'
is_nice2 = true

sample3 = 'jchzalrnumimnmhp'
is_nice3 = false

sample4 = 'haegwjzuvuyypxyu'
is_nice4 = false

sample5 = 'dvszwmarrgswjxmb'
is_nice5 = false

all_samples = "" +
  sample1 + "\n" +
  sample2 + "\n" +
  sample3 + "\n" +
  sample4 + "\n" +
  sample5 + "\n"

puts "Expected #{is_nice1}, Got: #{NicenessChecker.new(sample1).is_nice?}"
puts "Expected #{is_nice2}, Got: #{NicenessChecker.new(sample2).is_nice?}"
puts "Expected #{is_nice3}, Got: #{NicenessChecker.new(sample3).is_nice?}"
puts "Expected #{is_nice4}, Got: #{NicenessChecker.new(sample4).is_nice?}"
puts "Expected #{is_nice5}, Got: #{NicenessChecker.new(sample5).is_nice?}"

puts "Expected: 2, Got: #{NicenessCheckerMachine.new(all_samples).nice_count}"

puts "Lets see how many nice thingies we have this year: #{NicenessCheckerMachine.new(input).nice_count}"
