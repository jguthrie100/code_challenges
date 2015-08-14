#!/usr/bin/ruby 

# Challenge: Intermediate #227: https://www.reddit.com/r/dailyprogrammer/comments/3gpjn3/20150812_challenge_227_intermediate_contiguous/
#
# Work out how many chains there are in the input

# PASSED

class Matrix
  attr_reader :m, :height, :width, :num_chains
  
  def initialize(height, width)
    @m = Hash.new 
    @height = height
    @width = width
  end
  
  def get_cell(x, y)
    return m[[x, y]]
  end
  
  def set_cell(x, y, value)
    m[[x, y]] = value
  end
  
  # work out full chain that the given cell is part of
  def get_chain(x, y)
    m[[x, y]] = "-"  #reset this cell to - so we don't read it again
    get_chain(x, y-1) if(m[[x, y-1]] == "x")  # check if cell above == x
    get_chain(x+1, y) if(m[[x+1, y]] == "x")  # check if cell to the right == x
    get_chain(x, y+1) if(m[[x, y+1]] == "x")  # check if cell below == x
    get_chain(x-1, y) if(m[[x-1, y]] == "x")  # check if cel to the left == x
  end
  
  def to_s
    height.times do |y|
      width.times do |x|
        print get_cell(x, y)
      end 
      puts 
    end
  end
end

file = File.new("../input_files/intermediate_227_input1.txt", "r")

height, width = file.gets.chomp.split(" ")

m = Matrix.new(height.to_i, width.to_i)

# build matrix for the pattern
m.height.times do |row|
  line = file.gets.chomp
  m.width.times do |col|
    line[col].nil? ? m.set_cell(col, row, " ") : m.set_cell(col, row, line[col])
  end
end
file.close

# find chains 
num_chains = 0
m.height.times do |row|
  m.width.times do |col|
    if(m.get_cell(col, row) == "x")
      m.get_chain(col, row)
      num_chains += 1
    end
  end
end

puts num_chains