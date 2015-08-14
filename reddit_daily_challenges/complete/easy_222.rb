#!/usr/bin/ruby

# Challenge: Easy #222: https://www.reddit.com/r/dailyprogrammer/comments/3bi5na/20150629_challenge_221_easy_word_snake/

# Balancing Words: PASSED

input1 = "CONSUBSTANTIATION"
input2 = "WRONGHEADED"
input3 = "UNINTELLIGIBILITY"
input4 = "SUPERGLUE"

input = input3.upcase

def get_alphabet_pos(char)
  return char.upcase.ord-64        # gets ascii value of char and works out alphabet pos based on that
end

def get_weight(str, reverse_count=false)

  str = str.reverse if reverse_count
  
  weight = 0
  str.length.times do |i|
    weight += get_alphabet_pos(str.split("")[i]) * (i+1)
  end

  return weight
end

word = input
def get_balance_point(word)
  (1..word.length-2).each do |i|
    left_str = word[0..i-1]
    right_str = word[i+1..word.length]
    
    left_weight = get_weight(left_str, true)
    right_weight = get_weight(right_str)
    
    if left_weight == right_weight
      return [left_str, word[i], right_str, left_weight]
    end
  end
  return nil
end

result = get_balance_point(word)

if result
  puts "#{result[0]} #{result[1]} #{result[2]} - #{result[3]}"
else
  puts "#{word} DOES NOT BALANCE"
end