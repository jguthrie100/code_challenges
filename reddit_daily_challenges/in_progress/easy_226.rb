#!/usr/bin/ruby

# Challenge: Easy #226: https://www.reddit.com/r/dailyprogrammer/comments/3fmke1/20150803_challenge_226_easy_adding_fractions/

# NOT FINISHED

class Fraction 
  attr_accessor :numerator, :denominator
  
  def initialize(fraction)
    @numerator = fraction.split("/")[0].to_i
    @denominator = fraction.split("/")[1].to_i
  end
  
  def reduce()
    i = 2
    until(i >= denominator)
      if(numerator%i == 0 && denominator%i == 0)
        n1 = numerator / i
        d1 = denominator / i 
        @numerator = n1
        @denominator = d1
        i = 2
      else 
        i += 1 
      end
    end
  end
  
  def <=>(fraction)
    @denominator <=> fraction.denominator
  end
  
  def to_s()
    "#{@numerator}/#{@denominator}"
  end
end

def multiply_fractions(fraction1, fraction2)

  f1_d = fraction1.denominator
  f2_d = fraction2.denominator

  fraction1.numerator *= f2_d
  fraction1.denominator *= f2_d
  fraction2.numerator *= f1_d
  fraction2.denominator *= f1_d
  
  print "Reducing fractions..."
  fraction1.reduce
  fraction2.reduce

  return [fraction1, fraction2]
end

input0 = "1\n32/1024\n"
input1 = "2\n1/6\n3/10\n"
input2 = "4\n1/3\n1/4\n1/12\n3/28"
input3 = "5\n2/9\n4/35\n7/34\n1/2\n16/33\n"
input4 = "10\n1/7\n35/192\n61/124\n90/31\n5/168\n31/51\n69/179\n32/5\n15/188\n10/17\n"

input_arr = input2.split("\n")

fractions = Array.new(input_arr.delete_at(0).to_i)
fractions.length.times do |x|
  fractions[x] = Fraction.new(input_arr[x])
end

fractions.sort_by!(&:denominator)
i = 0

p fractions

finish = false
until(finish)
  
  print "sort: ..."
  fractions.sort_by!(&:denominator)
  p fractions

  print "check if f[0] == f[-1]..."
  if(fractions[0].denominator == fractions[-1].denominator)
    finish = true 
    break
  end 
  puts "not equal"
  puts
  
  print "compare f[#{i}].denominator to f[#{i+1}].denominator..."
  if(fractions[i].denominator == fractions[i+1].denominator)
    puts "equal (denominator == #{fractions[i].denominator})\n"
    puts
    print "check if i+1 (#{i+1}) == fractions.size-1..."
    if(i+1 == fractions.size-1)
      finish = true
      break
    end 
    puts ".. not equal"
    puts "i += 1"
    puts
    i += 1
  else
    puts "no match"
    puts
    print "multiply relevant fractions (#{i}, #{i+1}) (added to end of array)... #{fractions} => "
    fractions.concat(multiply_fractions(fractions.delete_at(i), fractions.delete_at(i)))
    p fractions
    puts
    i = 0 
  end 

  puts "sleep 2.."
  puts "start loop over. i = #{i}"
end

fractions.each do |x|
  puts "#{x.numerator}/#{x.denominator}"
end 