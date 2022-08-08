require_relative 'player'
require_relative 'board'

class Game
  attr_reader :player1, :player2, :current_player, :turn_count

  def start_game
    receive_player_names_and_pieces

    board = Board.new
    board.display_board

    loop_until_win_or_full(board)

    draw_or_win_message(board)
  end

  def receive_player_names_and_pieces
    print "Player 1 name:\t"
    player1_name = gets.chomp
    print "Player 1 piece:\t"
    player1_piece = gets.chomp

    player1_name = 'Player 1' if player1_name.strip == ''
    player1_piece = '1'       if player1_piece.strip == ''
    print "\n"

    print "Player 2 name:\t"
    player2_name = gets.chomp
    print "Player 2 piece:\t"
    player2_piece = gets.chomp


    player2_name  = 'Player 2' if player2_name.strip  == ''
    player2_piece = '2'        if player2_piece.strip == ''


    @player1 = Player.new(player1_name, player1_piece)
    @player2 = Player.new(player2_name, player2_piece)
  end

  
  def loop_until_win_or_full(board)
    first_turn
    until either_player_won? || full?(board)
      column_number = ask_for_valid_number
      
      if turn_count.even?
        @current_player = player1
      elsif turn_count.odd?
        @current_player = player2
      end
      
      board.drop(current_player.piece, column_number)
      system 'clear'
      board.display_board
      current_player.wins if board.four_successive_pieces?
      
      next_turn
    end
  end
  
  def either_player_won?
    player1.won || player2.won
  end

  def full?(board)
    board.board_array.all? { |row| row.none?('') }
  end
  
  def ask_for_valid_number(number = nil)
    until number.is_a?(Integer) && number.between?(1, 7) 
      print "Choose column number (1 to 7):\t"
      number = gets.chomp.to_i 
    end
    
    return number
  end

  def first_turn
    @turn_count = 0
  end
  
  def next_turn
    @turn_count += 1
  end
  
  def draw_or_win_message(board)
    return puts 'Draw!' if full?(board) 
    puts "#{winner} wins!"
  end
  
  
  def winner
    return player1.name if player1.won 
    return player2.name if player2.won
  end
end
