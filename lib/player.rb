class Player
  attr_reader :name, :piece, :won
  
  def initialize(name, piece)
    @name  = name
    @piece = piece
  end

  def wins
    @won = true
  end
end