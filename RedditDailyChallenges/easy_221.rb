#!/usr/bin/ruby

# Challenge: Easy #221: https://www.reddit.com/r/dailyprogrammer/comments/3bi5na/20150629_challenge_221_easy_word_snake/

# Create a word Snake: PASSED

input1 = "SHENANIGANS SALTY YOUNGSTER ROUND DOUBLET TERABYTE ESSENCE"
input2 = "DELOREAN NEUTER RAMSHACKLE EAR RUMP PALINDROME EXEMPLARY YARD"
input3 = "CAN NINCOMPOOP PANTS SCRIMSHAW WASTELAND DIRK KOMBAT TEMP PLUNGE ESTER REGRET TOMBOY"
input4 = "NICKEL LEDERHOSEN NARCOTRAFFICANTE EAT TO OATS SOUP PAST TELEMARKETER RUST THINGAMAJIG GROSS SALTPETER REISSUE ELEPHANTITIS"

input = input3

# returns a chunk of padding spaces
def make_padding(padding)
  return " " * padding
end

# prints a word to the console
def print_word(word, horizontal=true, padding=0)

  if horizontal                                     # print horizontally across screen
    puts make_padding(padding) + word               # print padding spaces followed by word
    
  else                                              # else print vertically
    word.split("")[1..word.length-2].each do |c|    # loop through each letter in the word, except the first and last
      puts make_padding(padding) + c                # only print one char per line (i.e. makes a vertical word)
    end
  end
end

# default values
horizontal = true
padding = 0

input_arr = input.split(" ")
input_arr.each do |w|                                   # loop through each word
  print_word(w, horizontal, padding)
  
  horizontal = !horizontal                          # Switch word rotation after each word
  if !horizontal
    padding = padding + w.length-1                  # if printing vertcally, increase padding by length of the previous word
  end
end

# Need this bit just to add the last character if the last word goes down vertically
if input_arr.length.even?
  print_word(input_arr.last.split("").last, horizontal, padding)
end