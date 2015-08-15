#!/usr/bin/ruby

# https://www.reddit.com/r/dailyprogrammer/comments/33hwwf/20150422_challenge_211_intermediate_ogre_maze/

# Navigate through maze. Use Depth First Search

# PASSED

class Ogre
  attr_accessor :pos
  
  def initialize
    @pos = Array.new
  end
  
  def move(dir)
    pos.size.times do |i|
      pos[i][0] += dir[0]
      pos[i][1] += dir[1]
    end
    return pos
  end
end

class Map
  attr_reader :map, :height, :width, :ogre, :gold
  
  def initialize(height, width)
    @height = height
    @width = width
    @map = Hash.new
    @ogre = Ogre.new
  end
  
  def set_cell(col, row, value)
    @map[[col, row]] = value
  end
  
  def get_cell(col, row)
    return nil if(map[[col, row]].nil?)
    return map[[col, row]]
  end
  
  def move_ogre(dir)
    return false if(valid_move?(dir) == false)
    ogre.pos.each do |ogre_pos|
      set_cell(ogre_pos[0], ogre_pos[1], "&")
    end
    ogre.move(dir)
    ogre.pos.each do |ogre_pos|
      set_cell(ogre_pos[0], ogre_pos[1], "@")
    end
  end
  
  # can ogre move in given direction
  def valid_move?(dir)
    return false if(dir[0].abs + dir[1].abs > 1) # only move 1 space in 1 NSEW direction at a time
    ogre.pos.each do |ogre_pos|
      next_cell = get_cell(ogre_pos[0] + dir[0], ogre_pos[1] + dir[1])
      if(next_cell == nil || next_cell == "O")
        return false
      end
    end
    return true
  end
  
  # has ogre already been on the space in the given direction
  def is_visited?(dir)
    visited_cells = 0
    ogre.pos.each do |ogre_pos|
      next_cell = get_cell(ogre_pos[0] + dir[0], ogre_pos[1] + dir[1])
      if(next_cell == "&")
        visited_cells += 1
      end
    end
    visited_cells == 2 ? (return true) : (return false)
  end
  
  def found_gold?()
    return ogre.pos.include?(gold)
  end
  
  # populate world map
  def populate(file)
    height.times do |h|
      line = file.gets
      width.times do |w|
        set_cell(w+1, h+1, line[w])
        if(line[w] == "@")
          ogre.pos.push([w+1, h+1])
        elsif(line[w] == "$")
          @gold = [w+1, h+1]
        end
      end
    end
    file.close
  end
  
  def to_s  
    height.times do |h|
      width.times do |w|
        print get_cell(w+1, h+1)
      end
      puts
    end
  end
end

# determine route to take (depth first search)
def find_route(map)
  search_path = Array.new
  directions = [[0, -1], [1, 0], [0, 1], [-1, 0]]
  
  loop do
    move = false
    directions.each do |dir|
      if(!map.is_visited?(dir) && map.valid_move?(dir))
        move = true
        map.move_ogre(dir)
        search_path.push(dir)
        return true if(map.found_gold?)
      end
      break if(move == true)
    end
    next if(move == true)
    # Only gets here if no move was available. Back track using stack of previous moves
    stack_dir = search_path.pop.dup
    stack_dir[0] *= -1
    stack_dir[1] *= -1
    map.move_ogre(stack_dir) # pop last move off stack and move ogre back
    
    return false if(search_path.size == 0)
  end
end

map = Map.new(10, 10)
map.populate(File.new("../input_files/intermediate_211_input1.txt", "r"))

find_route(map) ? map.to_s : (puts "No Path")