#! /usr/bin/ruby

# Challenge: https://www.reddit.com/r/dailyprogrammer/comments/3esrkm/20150727_challenge_225_easyintermediate/

# PASSED - needs extra work to complete intermediate part of challenge though

def removeFeature(line)
  return line.gsub(/ {2,}/, "").gsub(/[ \|]*\+-*?\+[ \|]*/, "").gsub(/[ \+]*\|.*?\|[ \+]*/, "")
end

count = 0
file = File.new("input_files/intermediate_225_input2.txt", "r")
text_arr = Array.new(file.gets.chomp.to_i)
while (line = file.gets)
    text_arr[count] = line
    count += 1
end
file.close

text = ""
text_arr.each do |a|
  a.chomp!
  a = removeFeature(a)
  if(a[-1] == "-")
    a.chop!
  else
    a += " "
  end
  
  a.gsub!(/^ +$/, "\n\n") # Create new paragragh on empty lines
  
  text += a
    
end

puts text