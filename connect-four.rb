#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
# Connect Four game 

#initialize game board array
$rows, $cols = 6, 7
$board = Array.new($rows*$cols)

$last_move = {row: nil, col: nil}

UP, DOWN, LEFT, RIGHT = 1, -1, -1, 1

#display the board, visualizing single array as rows and columns
def visualize_array
(0...$rows).each { |row|
  (0...$cols).each { |col|
    print row.to_s + " " + col.to_s + " "
    print "("  +  ($cols*row + col).to_s + ")   " # index into board array
  }
  puts
}
end

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

# returns the index into the array, or nil if the position is not on the board
def index (row, col)
  if (0...$rows).member? row
    if (0...$cols).member? col
      $cols*row + col
    end
  end
end

# returns a hash with the row, column and array index, or nil if the position is not on the board
def position (r,c)
  if (0...$rows).member? r
    if (0...$cols).member? c
      {row: r, col: c, pos: $cols*r + c}
    end
  end
end

# look right, left, up, down or diagonally (direction of +1 or -1) and count the number of matching squares
def find_match(r, c, row_dir, col_dir)
  count = 0
  match = true
  row = r
  col = c
  while match do
    col += col_dir # move right or left
    row += row_dir # move up or down
    square = position(row,col)
    if square && $board[square[:pos]] == $board[index(r,c)] then
      count += 1
    else
      match = false
    end
  end
  return count
end

def check_board
  #check for a winner
  #start from the last move, and look in all directions for the same color

  r,c = $last_move[:row], $last_move[:col]

  #from the last move, look to the left and right and count matches
  count = 1 # self
  count += find_match(r,c,0,RIGHT)
  count += find_match(r,c,0,LEFT)
  if count >= 4 then
    puts "Winner is " + $board[index(r,c)].to_s
    exit
  end

  #look down the same column as the last move (there can't be anything above it)
  count = 1 #self
  count += find_match(r,c,DOWN,0) #down
  if count >= 4 then
    puts "Winner is " + $board[index(r,c)].to_s
    exit
  end

  # look on the \ diagonal
  count = 1 #self
  count += find_match(r,c,DOWN,RIGHT) # down & to the right
  count += find_match(r,c,UP,LEFT) # up & to the left
  if count >= 4 then
    puts "Winner is " + $board[index(r,c)].to_s
    exit
  end

  # look on the / diagonal
  count = 1 #self
  count += find_match(r,c,DOWN,LEFT) # down & to the left
  count += find_match(r,c,UP,RIGHT) # up & to the right
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
