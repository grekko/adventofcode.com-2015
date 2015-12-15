input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class SantasBike
  attr_accessor :x, :y, :map
  COMPASS = {
    '^' => :move_north,
    '<' => :move_west,
    'v' => :move_south,
    '>' => :move_east
  }

  def initialize(x:, y:, map:)
    @x, @y, @map = x, y, map
  end

  def move(char)
    send COMPASS.fetch(char)
  end

  def deliver!
    @map[@x][@y] += 1
    self
  end

  def move_north
    @y -= 1
    self
  end

  def move_south
    @y += 1
    self
  end

  def move_east
    @x += 1
    self
  end

  def move_west
    @x -= 1
    self
  end
end

class DrunkenElfRemoteDeliveryService
  attr_accessor :input, :map, :bike

  def initialize(input)
    @input = input
    @map   = Hash.new { |h,k| h[k] = Hash.new(0) }
    @bike  = SantasBike.new(x: 0, y: 0, map: @map)
  end

  def deliver!
    bike.deliver!
    input.each_char do |c|
      bike.move c
      bike.deliver!
    end
    self
  end

  def number_of_presents
    input.length
  end

  def number_of_households_with_at_least_one_present
    map.map { |_, k| k.values.length }.reduce(:+)
  end
end

sample1 = '>'
sample2 = '^>v<'
sample3 = '^v^v^v^v^v'

puts "Expected 2 households: #{DrunkenElfRemoteDeliveryService.new(sample1).deliver!.number_of_households_with_at_least_one_present}"
puts "Expected 4 households: #{DrunkenElfRemoteDeliveryService.new(sample2).deliver!.number_of_households_with_at_least_one_present}"
puts "Expected 2 households: #{DrunkenElfRemoteDeliveryService.new(sample3).deliver!.number_of_households_with_at_least_one_present}"

# First guess: 136 was wrong
delivery = DrunkenElfRemoteDeliveryService.new(input).deliver!
puts "Santa delivered #{delivery.number_of_presents} presents to #{delivery.number_of_households_with_at_least_one_present} different households"
