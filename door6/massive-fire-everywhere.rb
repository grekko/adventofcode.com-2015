input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class HazardLightning
  REGEXP = %r{(.+)\s(\d+),(\d+)(.+)\s(\d+),(\d+)}

  attr_accessor :input, :grid

  def initialize(input)
    @input = input
    @grid = Hash.new { |h,k| h[k] = Hash.new(0) }
  end

  def process
    @input.each_line do |line|
      process_line line
    end
    self
  end

  def process_line(line)
    match = line.match(REGEXP)
    cmd     = match[1].gsub(' ', '_').to_sym
    x_start = match[2].to_i
    y_start = match[3].to_i
    x_end   = match[5].to_i
    y_end   = match[6].to_i
    x_axis = Range.new(x_start, x_end)
    y_axis = Range.new(y_start, y_end)
    x_axis.each do |x|
      y_axis.each do |y|
        send cmd, x: x, y: y
      end
    end
  end

  def toggle(x:, y:)
    grid[x][y] = (grid[x][y]-1)*-1
  end

  def turn_on(x:, y:)
    grid[x][y] = 1
  end

  def turn_off(x:, y:)
    grid[x][y] = 0
  end

  def lit_lights_count
    i = 0
    (0..999).each do |x|
      (0..999).each do |y|
        i += grid[x][y]
      end
    end
    i
  end
end

sample1 = 'turn on 0,0 through 999,999'
result1 = 1_000_000

sample2 = 'toggle 0,0 through 999,0'
result2 = 1_000

sample3 = 'turn off 499,499 through 500,500'
result3 = 0

puts "Expected #{result1}, Got: #{HazardLightning.new(sample1).process.lit_lights_count}"
puts "Expected #{result2}, Got: #{HazardLightning.new(sample2).process.lit_lights_count}"
puts "Expected #{result3}, Got: #{HazardLightning.new(sample3).process.lit_lights_count}"

puts "Let heaven be lit up! #{HazardLightning.new(input).process.lit_lights_count}"
