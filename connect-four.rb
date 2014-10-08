#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
# Connect Four game 

#initialize game board array
rows, cols = 6, 7
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

#choose a column to drop a piece into (0-6)
col = 2
board[37] = "R" #testing

# if row 0 is full, prompt for a different column
puts "column is full" if board[col]

#find the lowest empty row in that column

(rows-1).downto(0).each { |row|
  i = cols*row + col
  puts row.to_s + " " + col.to_s + "  " + (board[i] ? board[i] : ".")
}

# should do this "upside down" so all I have to find is the first empty position.
# users only pick a column, so they won't care how I number the rows.