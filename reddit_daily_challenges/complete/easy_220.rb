#!/usr/bin/ruby

# Challenge: Easy #220: https://www.reddit.com/r/dailyprogrammer/comments/3aqvjn/20150622_challenge_220_easy_mangling_sentences/

# PASSED

# Returns a hash of the position of each punctuation char in a word
def get_punct_list(word)
  punct_list = Hash.new
  word.length.times do |i|
    punct = /([[:punct:]])/.match(word[i])
    if punct
      punct_list[i] = punct[0]
      word[i] = ""
    end
  end
  return punct_list
end

def sort_word(word)
  
  punct_list = get_punct_list(word)
  
  # Downcase word, sort it, then capitalise first letter if required
  starts_with_capital = starts_with_capital?(word)
  word = word.downcase.chars.sort.join
  word.capitalize! if starts_with_capital
  
  # Insert punctuation chars in their relevant places
  # e variable basically shifts the insert point along
  #  due to quirk in the way I remove punctuation originally
  e = 0
  punct_list.each do |i, p|
    word.insert(i+e, p)
    e = e + 1
  end
  
  return word
end

# Returns true if word starts with a capital letter
def starts_with_capital?(word)
  return /^[[:upper:]]/.match(word)
end

input1 = "Eye of Newt, and Toe of Frog, Wool of Bat, and Tongue of Dog."
input2 = "Adder's fork, and Blind-worm's sting, Lizard's leg, and Howlet's wing."
input3 = "For a charm of powerful trouble, like a hell-broth boil and bubble."

input = input3
puts "Input:  #{input}"
print "Output: "
input.split(" ").each do |w|
  print sort_word(w) + " "
end
puts