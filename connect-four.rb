#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
# Connect Four game 

#initialize game board array
rows = 6
cols = 7
board = Array.new(rows*cols)

#display the board, visualizing single array as rows and columns
(0..rows-1).each { |row|
  (0..cols-1).each { |col|
    print row.to_s + " " + col.to_s + "   "
  }
  puts
}

puts
