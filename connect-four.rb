#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
# Connect Four game 

#initialize game board array
ROWS, COLS = 6, 7
$board = Array.new(ROWS*COLS)

$last_move = {row: nil, col: nil}

UP, DOWN, LEFT, RIGHT, SAME = -1, 1, -1, 1, 0
WIN = 4

#display the board, visualizing single array as rows and columns
def visualize_array
(0...ROWS).each { |row|
  (0...COLS).each { |col|
    print row.to_s + " " + col.to_s + " "
    print "("  +  (COLS*row + col).to_s + ")   " # index into board array
  }
  puts
}
end

def display_board
  (0...ROWS).each { |row|
    (0...COLS).each { |col|
      i = COLS*row + col
      print $board[i] ? $board[i].to_s + "  " : ".  "
    }
    puts
  }
end

def choose(player)
  done=false
  until done do

    puts "Player "+player.to_s+", choose a column (0-"+(COLS-1).to_s+")"
    col = gets.chomp.to_i

    # if row 0 for that column is filled in, prompt for a different column
    if $board[col] then puts "column is full"; redo; end

    #find the lowest empty row in that column
    #do this "upside down" so all I have to find is the first empty position.
    (ROWS-1).downto(0).each do |row|
      i = COLS*row + col
      if !$board[i] then
        $board[i] = player
        $last_move = {row: row, col: col, player: player}
        done=true
        break
      end
    end
  end
end

# returns the index into the array, or nil if the position is not on the board
def index (row, col)
  if (0...ROWS).member? row
    if (0...COLS).member? col
      COLS*row + col
    end
  end
end

# returns a hash with the row, column and array index, or nil if the position is not on the board
def position (r,c)
  if (0...ROWS).member? r
    if (0...COLS).member? c
      {row: r, col: c, pos: COLS*r + c}
    end
  end
end

def find_match(row_dir, col_dir)
  row,col = $last_move[:row], $last_move[:col]
  count = 0
  match = true
  while match do
    col += col_dir # move right or left
    row += row_dir # move up or down
    square = position(row,col)
    if square && $board[square[:pos]] == $last_move[:player] then
      count += 1
    else
      match = false
    end
  end
  return count
end

def find_row_match
  find_match(SAME,RIGHT) + find_match(SAME,LEFT)
end

def winner?(count)
  count + 1 >= WIN
end

def last_player
   $last_move[:player].to_s
end

def end_game
  puts "Winner is " + last_player
  exit
end

def check_row
  if winner? find_row_match then end_game end
end

def find_column_match
  find_match(DOWN,SAME)
end

def check_column
  puts "Checking column"
  if winner? find_column_match then end_game end
end

def find_backward_diagonal_match
  find_match(DOWN,RIGHT) + find_match(UP,LEFT)
end

def find_forward_diagonal_match
  find_match(DOWN,LEFT) + find_match(UP,RIGHT)
end

def check_diagonals
  puts "check_diagonals"
  if winner? find_backward_diagonal_match then end_game end
  if winner? find_forward_diagonal_match then end_game end
end

def check_tie
  #if we don't have a winner at this point, and all the spaces are filled (not nil), then it's a tie
  if $board.all?
    puts "It's a tie!"
    exit
  end
end

def check_board
  check_row
  check_column
  check_diagonals
  check_tie
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
