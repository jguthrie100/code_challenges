#! /usr/bin/ruby

# Challenge: Intermediate #225: https://www.reddit.com/r/dailyprogrammer/comments/3esrkm/20150727_challenge_225_easyintermediate/

# PASSED - needs extra work to complete intermediate part of challenge though

# removes +----+, |     |, as well as long sets of spaces

def removeFeature(line)
  return line.gsub(/ {2,}/, "").gsub(/[ \|]*\+-*?\+[ \|]*/, "").gsub(/[ \+]*\|.*?\|[ \+]*/, "")
end

file = File.new("../input_files/intermediate_225_input2.txt", "r")

input_arr = Array.new(file.gets.chomp.to_i)
count = 0

# build array of lines of input
while (line = file.gets)
    input_arr[count] = line
    count += 1
end
file.close

output = ""
input_arr.each do |a|
  a.chomp!
  a = removeFeature(a)
  
  if(a[-1] == "-")
    a.chop!
  else
    a += " "
  end
  
  a.gsub!(/^ +$/, "\n\n") # Create new paragragh on empty lines
  
  output += a
    
end

puts output