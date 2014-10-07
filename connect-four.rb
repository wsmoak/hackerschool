#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
# Connect Four game 

#initialize game board array
rows = 6
cols = 7
board = Array.new(rows*cols)

#display the board, visualizing single array as rows and columns
(0...rows).each { |row|
  (0...cols).each { |col|
    print row.to_s + " " + col.to_s + " "
    print "("  +  (cols*row + col).to_s + ")   " # index into board array
  }
  puts
}

puts
