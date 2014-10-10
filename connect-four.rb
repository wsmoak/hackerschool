#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
# Connect Four game 

#initialize game board array
$rows, $cols = 6, 7
$board = Array.new($rows*$cols)

$last_move = {row: nil, col: nil}

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
      print $board[i] ? $board[i].to_s + "  " : ".  "
    }
    puts
  }
end

def choose(player)
  done=false
  until done do

    puts "Player "+player.to_s+", choose a column (0-"+($cols-1).to_s+")"
    col = gets.chomp.to_i

    # if row 0 for that column is filled in, prompt for a different column
    if $board[col] then puts "column is full"; redo; end

    #find the lowest empty row in that column
    #do this "upside down" so all I have to find is the first empty position.
    ($rows-1).downto(0).each { |row|
      i = $cols*row + col
      if !$board[i] then
        $board[i] = player
        $last_move = {row: row, col: col}
        done=true
        break
      end
    }
  end
end

def index (row, col)
  if (0...$rows).member? row
    if (0...$cols).member? col
      $cols*row + col
    end
  end
end

def neighbors_index (r, c)
  [index(r-1,c-1), index(r-1,c), index(r-1,c+1),
   index(r,c-1),                 index(r,c+1),
   index(r+1,c-1), index(r+1,c), index(r+1,c+1) ]
end

def position (r,c)
  if (0...$rows).member? r
    if (0...$cols).member? c
      {row: r, col: c, pos: $cols*r + c}
    end
  end
end

def neighbors (r, c)
  [ position(r-1,c-1), position(r-1,c), position(r-1,c+1),
    position(r,c-1),                    position(r,c+1),
    position(r+1,c-1), position(r+1,c), position(r+1,c+1) ].compact
end

def check_board
  #check for a winner
  #start from the last move, and look out in all directions for the same color

  puts "Game Board array is " + $board.inspect

  r,c = $last_move[:row], $last_move[:col]
  puts "Last Move was " + $board[index(r,c)].to_s + " at " + $last_move[:row].to_s + " " + $last_move[:col].to_s

  #from the last move, look to the left and right and count matches
  count = 1 # last move
  match = true
  col = c
  while match do
    col -= 1
    left = position(r,col)
    puts "left is " + left.inspect
    if left && $board[left[:pos]] == $board[index(r,c)] then
      puts "Match to the left!"
      count += 1
    else
      match = false
    end
  end
  puts "Count is " + count.to_s
  match = true
  col = c
  while match do
    col += 1
    right = position(r,col)
    puts "right is " + right.inspect
    if right && $board[right[:pos]] == $board[index(r,c)] then
      puts "Match to the right!"
      count += 1
    else
      match = false
    end
    puts "Count is " + count.to_s
  end

  if count >= 4 then
    puts "Winner is " + $board[index(r,c)].to_s
    exit
  end

  #if we don't have a winner at this point, and all the spaces are filled (not nil), then it's a tie
  if $board.all?
    puts "It's a tie!"
    exit
  end
end

def play
  loop do
    choose(:B)
    display_board
    check_board

    choose(:R)
    display_board
    check_board
  end
end

display_board
play
