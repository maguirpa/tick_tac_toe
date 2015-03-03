WINNERS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

def initialize_board 
  b = {}
  (1..9).each {|num| b[num] = " "}
  board = b
end

def draw_board(board)
  system 'clear'
  puts " #{board[1]} | #{board[2]} | #{board[3]}"
  puts "-----------"
  puts " #{board[4]} | #{board[5]} | #{board[6]}"
  puts "-----------"
  puts " #{board[7]} | #{board[8]} | #{board[9]}"
end

def empty_spaces_hash(board)
    board.select {|key, _| board[key] == ' '}.keys
end

def player_pick(board)
  begin
  puts "Please chose a square"
  player_square = gets.chomp.to_i
  end while !empty_spaces_hash(board).include?(player_square)
  board[player_square] = 'X'
end

def computer_pick(board)
  sleep(1)
  go_for_win = two_in_a_row(board, 'O')
  defend = two_in_a_row(board, 'X')
  if go_for_win
    board[go_for_win] = 'O'
  elsif defend
    board[defend] = 'O'
  else
  computer_choice = empty_spaces_hash(board).sample
  board[computer_choice] = "O"
  end
end

def winner(board)
  WINNERS.each do |winner|
    return "Player" if board.values_at(*winner).count('X') == 3
    return "Computer" if board.values_at(*winner).count('O') == 3
  end
  nil
end

def two_in_a_row(board, marker)
  two_hit = WINNERS.select do |line|
  board.values_at(*line).count(marker) == 2
  end
  two_hit.flatten!
  chosen_square = two_hit.select {|sq| board[sq] == ' '}
  chosen_square[0]
end

begin
  board = initialize_board
  draw_board(board)

  begin
    player_pick(board)
    draw_board(board)
    computer_pick(board)
    draw_board(board)
  end until empty_spaces_hash(board).empty? || winner(board)

  if winner(board)
    puts "#{winner(board)} wins!"
  else
    puts "It's a tie."
  end

  puts "Would you like to play again?(y/n)"
  answer = gets.chomp.upcase

end until answer == 'N' 









