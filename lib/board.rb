class Board
  attr_accessor :board

  def drop(piece, coordinates)
    row_number    = coordinates[0]
    column_number = coordinates[1]

    board[row_number][column_number] = piece
  end
end