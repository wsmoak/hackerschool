#! /usr/bin/ruby

# Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | September 2014
# Tic Tac Toe
# Prompts each player in turn to choose a row and column
# Identifies a winner or a tie

# set up 3x3 board grid initialized with nil values
$game_board = Array.new(3) { Array.new(3) }

$winner = nil
               
# display the board grid
def display_board
  for row in $game_board
    for square in row
      print square ? square.to_s + "  " : ".  "           
    end
    puts
  end
end

# prompt for a row and column
def choose(player)
  done = false
  until done do
    
    puts "Player "+player.to_s+", choose a row (0-2)"
    row = gets.chomp.to_i
    redo if invalid?(row)
    
    puts "Player "+player.to_s+", choose a column (0-2)"
    col = gets.chomp.to_i
    redo if invalid?(col)
        
    if $game_board[row][col]
      puts "That square [#{row},#{col}] is already used. Try again."
      redo
    end    
    
    $game_board[row][col] = player
    done = true
  end
end

def invalid?(input)
  input < 0 || input > 2
end

# determine if there is a winner or a tie
def check_board

  # starting at top left, check top row, diagonal and left column
  if ( ($game_board[0][0] == $game_board[0][1] && $game_board[0][0] == $game_board[0][2]) ||
       ($game_board[0][0] == $game_board[1][1] && $game_board[0][0] == $game_board[2][2]) ||
       ($game_board[0][0] == $game_board[1][0] && $game_board[0][0] == $game_board[2][0]) )
    $winner = $game_board[0][0] 

  # starting at top middle, check middle column
  elsif  ($game_board[0][1] == $game_board[1][1] && $game_board[0][1] == $game_board[2][1])
    $winner = $game_board[0][1]

  #starting at top right, check right column and diagonal
  elsif (($game_board[0][2] == $game_board[1][2] && $game_board[0][2] == $game_board[2][2]) ||
         ($game_board[0][2] == $game_board[1][1] && $game_board[0][2] == $game_board[2][0]))
    $winner = $game_board[0][2]

  #starting at middle left, check middle row
  elsif ($game_board[1][0] == $game_board[1][1] && $game_board[1][0] == $game_board[1][2])
    $winner = $game_board[1][0]

  #starting at bottom left, check bottom row
  elsif   ($game_board[2][0] == $game_board[2][1] && $game_board[2][0] == $game_board[2][2])
    $winner = $game_board[2][0]
  end
  
  if $winner
    puts $winner.to_s + " wins!" 
    exit
  end
  
  #if we don't have a winner at this point, and all the spaces are filled (not nil), then it's a tie
  if $game_board.flatten.all?
    puts "It's a tie!"
    exit
  end
  
end

def play
  loop do
    choose(:X)
    display_board
    check_board
    
    choose(:O)
    display_board
    check_board  
  end
end

#Start the game
  display_board
  play

