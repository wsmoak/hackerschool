#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
# Connect Four game 

#initialize game board array
$rows, $cols = 6, 7
#$board = Array.new($rows*$cols)
$board = [nil,nil,nil,nil,nil,nil,nil,
          "R","B","R","B","R","B","R",
          "B","R","B","R","B","R","B",
          "R","B","R","B","R","B","R",
          "B","R","B","R","B","R","B",
          "R","B","R","B","R","B","R" ]

#display the board, visualizing single array as rows and columns
(0...$rows).each { |row|
  (0...$cols).each { |col|
    print row.to_s + " " + col.to_s + " "
    print "("  +  ($cols*row + col).to_s + ")   " # index into board array
  }
  puts
}

puts

def display_board
  (0...$rows).each { |row|
    (0...$cols).each { |col|
      i = $cols*row + col
      print $board[i] ? $board[i] + "  " : ".  "
    }
    puts
  }
end

def choose(player)
  done=false
  until done do

    puts "Player "+player+", choose a column (0-"+($cols-1).to_s+")"
    col = gets.chomp.to_i

    # if row 0 is full, prompt for a different column
    if $board[col] then puts "column is full"; redo end

    #find the lowest empty row in that column
    #do this "upside down" so all I have to find is the first empty position.
    ($rows-1).downto(0).each { |row|
      i = $cols*row + col
      if !$board[i] then
        $board[i] = player
        done=true
        break
      end
    }
  end
end

def check_board

  #TODO check for a winner

  #if we don't have a winner at this point, and all the spaces are filled (not nil), then it's a tie
  if $board.all?
    puts "It's a tie!"
    exit
  end
end

def play
  loop do
    choose("B")
    display_board
    check_board

    choose("R")
    display_board
    check_board
  end
end

display_board
play
