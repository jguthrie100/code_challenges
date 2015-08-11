#!/usr/bin/ruby

# Challenge: https://www.reddit.com/r/dailyprogrammer/comments/3ggli3/20150810_challenge_227_easy_square_spirals/

class Spiral
  attr_reader :size, :current_cell
  
  def initialize(size)
    @size = size
    @count = 1
    @next_cell = [(size + 1)/2, (size + 1)/2]
    @current_cell = [0,0]
    @next_move = [0, 1]
    
    @matrix = Hash.new(0)
    
  end
  
  def add_cell()
    @matrix[[@next_cell[0], @next_cell[1]]] = @count
    current_cell[0] = @next_cell[0]
    current_cell[1] = @next_cell[1]
    update_next_move()
      
  end 
  
  def update_next_move()
    case @next_move
    when [0, 1]
      if(@matrix[[@next_cell[0]+1, @next_cell[1]]] == 0)
        @next_move = [1, 0]
      end
    when [1, 0]
      if(@matrix[[@next_cell[0], @next_cell[1]-1]] == 0)
        @next_move = [0, -1]
      end
    when [0, -1]
      if(@matrix[[@next_cell[0]-1, @next_cell[1]]] == 0)
        @next_move = [-1, 0]
      end
    when [-1, 0]
      if(@matrix[[@next_cell[0], @next_cell[1]+1]] == 0)
        @next_move = [0, 1]
      end
    end
    
    @count += 1
    @next_cell[0] = @next_cell[0] + @next_move[0]
    @next_cell[1] = @next_cell[1] + @next_move[1]
    
  end
  
  def to_s()
    size.times do |y|
      size.times do |x|
        print @matrix[[x+1, y+1]].to_s.rjust(2, ' ')
      end 
      puts 
    end 
  end
    
end 

print "1st arg: "
spiral = Spiral.new(gets.chomp.to_i)

print "2nd arg: "
arg = gets.chomp 

if(arg.include? " ")
  target_cell = "[#{arg.split(" ")[0]}, #{arg.split(" ")[1]}]"
else
  target_count = arg.to_i
end

(1...(spiral.size*spiral.size)+1).each do |x|
  spiral.add_cell
  
  if(spiral.current_cell.to_s == target_cell)
    puts x 
  end
  
  if(x == target_count)
    puts "#{spiral.current_cell}"
  end
end