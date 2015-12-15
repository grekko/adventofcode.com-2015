input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class Package
  attr_accessor :w, :h, :l
  def initialize(w:, h:, l:)
    @w, @h, @l = w, h, l
  end

  def paper_needed_in_square_feet
    ( 2 * l * w ) + ( 2 * w * h ) + ( 2 * h * l ) + shortest_side
  end

  private

  def shortest_side
    [l*w, w*h, h*l].min
  end
end

puts "Expected: 58, #{Package.new(w: 2, h: 3, l: 4).paper_needed_in_square_feet}"
puts "Expected: 43, #{Package.new(w: 1, h: 1, l: 10).paper_needed_in_square_feet}"

total_square_feet = input.each_line.map do |dim|
  w, h, l = dim.split('x').map &:to_i
  Package.new(w: w, h: h, l: l).paper_needed_in_square_feet
end.inject(0) { |sum, square_feet| sum += square_feet }

puts "The elves should order: #{total_square_feet} of square of feet paper"
