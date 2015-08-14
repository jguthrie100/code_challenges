#!/usr/bin/ruby

# Challenge: Intermediate #226: https://www.reddit.com/r/dailyprogrammer/comments/3fva66/20150805_challenge_226_intermediate_connect_four/

# Connect 4 game: PASSED

class Board
  attr_reader :board, :cols, :rows
  
  def initialize()
    @board = Hash.new
    @cols = "abcdefg".split("")
    @rows = "123456".split("")
    
    rows.each do |r|
      cols.each do |c|
        @board[[c, r]] = "."
      end
    end
  end
  
  def add_piece(c)
    /[[:upper:]]/.match(c) ? piece = "X" : piece = "O"  # Determine who made the move
    col = c.downcase
      
    rows.each do |row|
      if(board[[col, row]] == ".")
        @board[[col, row]] = piece
        return "#{col}#{row}"
      end
    end
  end
  
  # get line of pieces
  def get_line(piece, dir)
    c, r = piece.split("")
    player = board[[c, r]]
    player == "X" ? line = ["#{c.upcase}#{r}"] : line = ["#{c.downcase}#{r}"]
    dir_checked = 0
    
    while(dir_checked < 2)
      c = (c.ord + dir[0]).chr
      r = "#{r.to_i + dir[1]}"
      
      if(board[[c, r]] == player)
        player == "X" ? line.push("#{c.upcase}#{r}") : line.push("#{c.downcase}#{r}")
      else
        # switch direction
        dir_checked += 1
        dir[0] *= -1
        dir[1] *= -1
        c, r = piece.split("")
      end
    end
    
    return line
  end
  
  def four_in_a_row?(piece)
    dirs = [[0, 1], [1, 1], [1, 0], [1, -1]] # directions: N, NE, E, SE
    dirs.each do |d|
      line = get_line(piece, d)
      return line.sort if(line.size >= 4)
    end
    return false
  end
end

b = Board.new
file = File.new("../input_files/intermediate_226_input1.txt", "r")
moves_list = Array.new

# populate array of moves
while(line = file.gets)
  moves_list.concat(line.chomp.split(" "))
end
file.close

move_count = 1
moves_list.each do |move|
  piece = b.add_piece(move)
  if(winning_line = b.four_in_a_row?(piece))
    /[[:upper:]]/.match(winning_line[0][0]) ? (print "X ") : (print "O ")
    puts "won at move #{move_count.to_i} (with #{winning_line.join(' ')})"
    break
  end
  move_count += 0.5
end