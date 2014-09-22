#! /usr/bin/ruby

for x in 1..100 do
  if x % 15 == 0
    puts "CracklePop"
  elsif x % 5 == 0
    puts "Pop"
  elsif x % 3 == 0
    puts "Crackle"
  else 
    puts x  
  end
end