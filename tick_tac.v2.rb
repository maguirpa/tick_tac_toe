WINNERS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

player_total_wins = 0
computer_total_wins = 0
total_ties = 0

require 'pry'

def initialize_board
  b = {}
  (1..9).each {|position| b[position] = ' '}
  b
end

def draw_board(board)
  system 'clear'
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts "------------"
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts "------------"
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
end

def empty_spaces(board)
  board.select {|key, _| board[key] == ' ' }.keys
end

def player_pick(board)
  begin
    puts "Pick a square please."
    position = gets.chomp.to_i
    square_taken = false
    if empty_spaces(board).include?(position)
      board[position] = 'X' 
      square_taken = true
    else
      puts "That square is taken, please pick again."
    end
  end while !square_taken
end

def winner(board)
  WINNERS.each do |winner|
    if board[winner[0]] == 'X' && board[winner[1]] == 'X' && 
       board[winner[2]] == 'X'
      return "Player"
    elsif board[winner[0]] == 'O' && board[winner[1]] == 'O' &&
          board[winner[2]] == 'O'
      return 'Computer'
    end
  end
  return nil
end

def winning_values(combo, board)
  winner = {combo[0] => board[combo[0]], 
            combo[1] => board[combo[1]], 
            combo[2] => board[combo[2]]}
end

def strategy(board, marker)
  win_move = WINNERS.select do |combo|
  combo_hash = winning_values(combo, board)
  check_for_two_in_row(combo_hash, marker)
  end
  win_move.flatten!
  winning_square = win_move.select {|square| board[square] == ' '}
  winning_square[0]
end

def computer_pick(board)
  computer_win_move = strategy(board, 'O')
  computer_defend_move = strategy(board, 'X')
  if computer_win_move
    board[computer_win_move] = 'O'
  elsif computer_defend_move
    board[computer_defend_move] = 'O'
  else position = empty_spaces(board).sample
    board[position] = 'O'
  end
end

def check_for_two_in_row (two_row, mrkr)
  if two_row.values.count(mrkr) == 2
     two_row.select {|_, v| v == ' '}.keys.first
  else
    false
  end
end

def gameplay(board)
  player_pick(board)
  draw_board(board)
    if winner(board)
      return "Player"
    end
  sleep(1)
  computer_pick(board)
  draw_board(board)  
end

begin
  board = initialize_board
  draw_board(board)
  begin 
    gameplay(board)
  end until empty_spaces(board).empty? || winner(board)
  
  if winner(board)
    puts "\n#{winner(board)} wins!\n"
  else
    puts "\nIt's a tie!\n"
  end

  puts 'Play again?(y/n)'
  play_again = gets.chomp.upcase

end while play_again == 'Y'










