input = IO.binread(File.expand_path('../input.txt', __FILE__)).chomp

class MiningMachine
  require 'openssl'
  attr_accessor :input

  def initialize(input)
    @input = input
    @counter = 0
  end

  def next_int
    begin
      @counter += 1
    end while !md5_scrambled_text_valid?
    @counter
  end

  def md5_scrambled_text_valid?
    md5_scrambled_text.start_with?("00000")
  end

  def md5_scrambled_text
    OpenSSL::Digest::MD5.digest("#{input}#{@counter}").unpack('H*').first
  end
end

sample1 = 'abcdef'
expected1 = 609043

sample2 = 'pqrstuv'
expected2 = 1048970

puts "Expected #{expected1}, Got: #{MiningMachine.new(sample1).next_int}"
puts "Expected #{expected2}, Got: #{MiningMachine.new(sample2).next_int}"

puts "Leeets make some money! Secret-Sauce: #{MiningMachine.new(input).next_int}"
