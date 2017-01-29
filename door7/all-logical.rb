require 'byebug'

input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class GateConnector
  attr_reader :input, :wires

  class RawSource
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def evaluate(_)
      value
    end
  end

  class Gate
    attr_accessor :inputs

    def initialize(inputs = {})
      @inputs = {}
    end
  end

  class Wire
    attr_reader :value

    def initialize(source, wires)
      @source = source
      @wires = wires
    end

    def value
      source.evaluate(wires)
    end
  end

  class NotGate < Gate
  end

  class AndGate < Gate
  end

  class OrGate < Gate
  end

  class LshiftGate < Gate
  end

  class RshiftGate < Gate
  end

  def initialize(input)
    @input = input
    @wires = {}
  end

  def process
    @input.each_line do |line|
      klass, inputs, output_wire_id = parse_line(line)
      gate_or_source = klass.new(inputs.merge(wires: @wires))
      @wires[output_wire_id] = gate_or_source
    end
    byebug
  end

  def parse_line(line)
    source, id = line.split(' -> ')
    case
    when source.match(/\d+/)
      return RawSource, { input: source }, id
    when source.include?('NOT')
      return NotGate, parse_not(source), id
    when source.include?('AND')
      return AndGate, parse_and(source), id
    when source.include?('OR')
      return OrGate, parse_or(source), id
    when source.include?('LSHIFT')
      return LshiftGate, parse_lshift(source), id
    when source.include?('RSHIFT')
      return RshiftGate, parse_rshift(source), id
    else
      raise ArgumentError, "Unidentified input: #{line}"
    end
  end

  def parse_not(source)
    { input: source.split(' ').last }
  end

  def parse_and(source)
    { inputs: source.split(' AND ') }
  end

  def parse_or(source)
    { inputs: source.split(' OR ') }
  end

  def parse_lshift(source)
    { inputs: source.split(' LSHIFT ') }
  end

  def parse_rshift(source)
    { inputs: source.split(' RSHIFT ') }
  end
end

sample1 = <<-EOF
123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i
EOF

result1 = <<-EOF
d: 72
e: 507
f: 492
g: 114
h: 65412
i: 65079
x: 123
y: 456
EOF

puts "Expected\n#{result1}, Got: #{GateConnector.new(sample1).process.ordered_wire_values}"
