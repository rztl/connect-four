require_relative 'player'
require_relative 'board'

class Game
  attr_reader :player1, :player2, :current_player, :turn_count

  def start_game
    print "Player 1 name:\t"
    player1_name = gets.chomp
    print "Player 1 piece:\t"
    player1_piece = gets.chomp

    print "\n"
    
    print "Player 2 name:\t"
    player2_name = gets.chomp
    print "Player 2 piece:\t"
    player2_piece = gets.chomp

    @player1 = Player.new(player1_name, player1_piece)
    @player2 = Player.new(player2_name, player2_piece)

    board = Board.new
    board.display_board
    first_turn

    until either_player_won?
      print "Choose column number (0 to 6):\t"
      column_number = gets.chomp.to_i

      if turn_count.even?
        @current_player = player1
      elsif turn_count.odd?
        @current_player = player2
      end

      board.drop(current_player.piece, column_number)
      board.display_board
      current_player.wins if board.four_successive_pieces?

      next_turn
    end

    puts "#{current_player.name} wins!"
  end
  



  private

  def either_player_won?
    player1.won || player2.won
  end

  def first_turn
    @turn_count = 0
  end

  def next_turn
    @turn_count += 1
  end
end
