input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class Walker
  attr_accessor :x, :y, :map, :name
  COMPASS = {
    '^' => :move_north,
    '<' => :move_west,
    'v' => :move_south,
    '>' => :move_east
  }

  def initialize(x:, y:, map:, name:)
    @x, @y, @map, @name = x, y, map, name
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
  attr_accessor :input, :map, :santa, :robot

  def initialize(input)
    @input = input
    @map   = Hash.new { |h,k| h[k] = Hash.new(0) }
    @santa = Walker.new(x: 0, y: 0, map: @map, name: 'Santa')
    @robot = Walker.new(x: 0, y: 0, map: @map, name: 'Robot')
  end

  def deliver!
    targets = [santa, robot]
    santa.deliver!
    robot.deliver!
    index = 0
    input.each_char do |c|
      walker = targets[index]
      walker.move c
      walker.deliver!
      index = (index == 0 ? 1 : 0)
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

sample1 = '^v'
sample2 = '^>v<'
sample3 = '^v^v^v^v^v'

puts "Expected 3 households: #{DrunkenElfRemoteDeliveryService.new(sample1).deliver!.number_of_households_with_at_least_one_present}"
puts "Expected 3 households: #{DrunkenElfRemoteDeliveryService.new(sample2).deliver!.number_of_households_with_at_least_one_present}"
puts "Expected 11 households: #{DrunkenElfRemoteDeliveryService.new(sample3).deliver!.number_of_households_with_at_least_one_present}"

delivery = DrunkenElfRemoteDeliveryService.new(input).deliver!
puts "Santa and Robot delivered #{delivery.number_of_presents} presents to #{delivery.number_of_households_with_at_least_one_present} different households"
