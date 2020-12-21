class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }
  attr_reader :pegs

  def self.valid_pegs?(arr)
    arr.all? {|ele| POSSIBLE_PEGS.has_key?(ele.upcase)}
  end


  def initialize (arr)
    raise "Enetered PEGS are not valid." if !self.class.valid_pegs?(arr)
    @pegs = arr.map(&:upcase)
  end

  def self.random(length)
    p_pegs = []
    POSSIBLE_PEGS.each_key {|k| p_pegs << k}
    arr = []
    length.times {arr << p_pegs.sample}
    Code.new(arr)
  end

  def self.from_string(string)
    arr = []
    string.each_char {|ch| arr << ch}
    Code.new(arr)
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(code_inst)
    count = 0
    code_inst.pegs.each_with_index {|ele, i| count += 1 if @pegs[i] == code_inst[i]}
    count
  end

  def num_near_matches(code_inst)
    count = 0
    code_inst.pegs.each_with_index {|ele, i| count += 1 if @pegs.include?(ele) && @pegs[i] != ele}
    count 
  end

  def == (code_inst)
    @pegs == code_inst.pegs
  end
end
