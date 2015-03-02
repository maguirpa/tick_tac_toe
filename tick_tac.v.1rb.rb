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

def draw_board (b)
  system 'clear'
  puts " #{b[1]} | #{b[2]} | #{b[3]} "
  puts "------------"
  puts " #{b[4]} | #{b[5]} | #{b[6]} "
  puts "------------"
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
end

def empty_space (b)
  b.select {|key, value| b[key] == ' ' }.keys
end

def player_pick (b)
  begin
    puts "Pick a square please."
    position = gets.chomp.to_i
    square_taken = false
    if empty_space(b).include?(position)
      b[position] = 'X' 
      square_taken = true
    else
      puts "That square is taken, please pick again."
    end
  end while square_taken == false
end

def winner (b)
  WINNERS.each do |winner|
    if b[winner[0]] == 'X' && b[winner[1]] == 'X' && b[winner[2]] == 'X'
      return "Player"
    elsif b[winner[0]] == 'O' && b[winner[1]] == 'O' && b[winner[2]] == 'O'
      return 'Computer'
    end
  end
  return nil
end

def computer_pick(b)
  sleep(1)
  position = nil
  WINNERS.each do |line|
    hsh = {line[0] => b[line[0]], line[1] => b[line[1]], line[2] => 
      b[line[2]]}
    found_two = check_for_two_in_row(hsh, 'X')
    go_for_win = check_for_two_in_row(hsh, 'O')
    if go_for_win
      position = go_for_win
    elsif found_two
      position = found_two
    end
  end
  if position == nil
    position = empty_space(b).sample
  end
  b[position] = 'O'
end

def check_for_two_in_row (hsh, mrkr)
  if hsh.values.count(mrkr) == 2
    hsh.select {|k, v| v == ' '}.keys.first
  else
    false
  end
end

def gameplay (b)
  player_pick(b)
  draw_board(b)
  if empty_space(b).empty? || winner(b)
    return "Player"
  end
  computer_pick(b)
  draw_board(b)  
end

# Begin Gameplay
begin
  board = initialize_board
  draw_board(board)
  switch_start = [0,1].sample

  if switch_start == 0
    puts "Player goes first!"
    begin 
      gameplay(board)
    end until empty_space(board).empty? || winner(board)
  else
    puts "Computer goes first!"
    board[5] = 'O'
    sleep(1)
    draw_board(board)
    begin
      gameplay(board)
    end until empty_space(board).empty? || winner(board)
  end

  if winner(board)
    puts "\n#{winner(board)} wins!\n"
    if winner(board) == 'Player'
      player_total_wins += 1
    else
      computer_total_wins += 1
    end
  else
    puts "\nIt's a tie!\n"
    total_ties += 1
  end

  puts 'Play again?(y/n)'
  play_again = gets.chomp.upcase
end while play_again == 'Y'

puts "\nPlayer wins: #{player_total_wins}"
puts "\nComputer wins: #{computer_total_wins}"
puts "\nTotal ties: #{total_ties}"

puts "\nThanks for playing!\n"














