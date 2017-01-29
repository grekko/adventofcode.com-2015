input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class Package
  attr_accessor :w, :h, :l
  def initialize(w:, h:, l:)
    @w, @h, @l = w, h, l
  end

  def ribbon_needed
    [w+w+l+l, h+h+w+w, h+h+l+l].min + bow_ribbon
  end

  private

  def bow_ribbon
    w*h*l
  end
end

puts "Expected: 34, #{Package.new(w: 2, h: 3, l: 4).ribbon_needed}"
puts "Expected: 14, #{Package.new(w: 1, h: 1, l: 10).ribbon_needed}"

total_ribbon = input.each_line.map do |dim|
  w, h, l = dim.split('x').map &:to_i
  Package.new(w: w, h: h, l: l).ribbon_needed
end.reduce(:+)

puts "The elves should order: #{total_ribbon} feet ribbon in length"
