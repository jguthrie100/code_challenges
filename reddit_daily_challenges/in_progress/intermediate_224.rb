#!/usr/bin/ruby

# Challenge: Intermediate #224: https://www.reddit.com/r/dailyprogrammer/comments/3e5b0o/20150722_challenge_224_intermediate_detecting/

class Cell 
  attr_accessor :x, :y, :value
  
  def initialize(x, y, value)
    @x = x 
    @y = y 
    @value = value 
  end
  
  def to_s 
    print value
  end
end

class Matrix 
  attr_accessor :matrix, :height, :width, :boxes
  
  def initialize
    @matrix = Hash.new
    @boxes = Hash.new
    @height = 0
    @width = 0
  end
  
  def add_cell(c)
    @width = c.x+1 if(c.x >= width)
    @height = c.y+1 if(c.y >= height)
    
    @matrix[[c.x, c.y]] = c
  end
  
  def get_cell(x, y)
    return matrix[[x, y]]
  end
  
  def next_corner_right(c)
    return nil if(c.nil?)
    if(!matrix[[c.x+1, c.y]].nil? && matrix[[c.x+1, c.y]].value == "+")
      return matrix[[c.x+1, c.y]]
    elsif(!matrix[[c.x+1, c.y]].nil? && matrix[[c.x+1, c.y]].value == "-")
      return next_corner_right(matrix[[c.x+1, c.y]])
    else
      return nil
    end
  end
  
  def next_corner_down(c)
    return nil if(c.nil?)
    if(!matrix[[c.x, c.y+1]].nil? && matrix[[c.x, c.y+1]].value == "+")
      return matrix[[c.x, c.y+1]]
    elsif(!matrix[[c.x, c.y+1]].nil? && matrix[[c.x, c.y+1]].value == "|")
      return next_corner_down(matrix[[c.x, c.y+1]])
    else
      return nil
    end
  end
  
  def add_box(c1, c2, c3, c4)
    boxes[[c1, c2, c3, c4]] = true
  end
  
  def get_box(c1, c2, c3, c4)
    return boxes[[c1, c2, c3, c4]]
  end
  
  def to_s
    height.times do |y|
      width.times do |x|
        print matrix[[x, y]].to_s
      end 
      puts 
    end
  end
end

file = File.new("../input_files/intermediate_224_input2.txt", "r")

matrix = Matrix.new
row = 0

# build matrix for the pattern
while (line = file.gets)
  line.chomp.size.times do |col|
    matrix.add_cell(Cell.new(col, row, line.split("")[col]))
  end
  row += 1
end
file.close

matrix.height.times do |y|
  matrix.width.times do |x|
    matrix.add_cell(Cell.new(x, y, " ")) if(matrix.get_cell(x, y).nil?) # fill any nil cells with a space
    
    if(matrix.get_cell(x, y).value == "+")
      c1 = matrix.get_cell(x, y)
      puts "c1: [#{c1.x},#{c1.y}]"
      c2 = matrix.next_corner_right(c1)
      while(!c2.nil?)
        sleep 1
        puts "c2: [#{c2.x},#{c2.y}]"
        c3 = matrix.next_corner_down(c1)
        while(!c3.nil?)
          sleep 1
          puts "c3: [#{c3.x},#{c3.y}]"
          c4 = matrix.next_corner_down(c2)
          while(!c4.nil?)
            c4 = matrix.next_corner_right(c3)
            puts "Found square: [#{c1.x},#{c1.y}], [#{c2.x},#{c2.y}], [#{c3.x},#{c3.y}], [#{c4.x},#{c4.y}]"
          end
          c3 = matrix.next_corner_down(c3)
        end
        c2 = matrix.next_corner_right(c2)
      end
    end 
  end
end