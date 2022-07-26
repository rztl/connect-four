class Board 
  attr_accessor :board_array, :column
  
  def initialize(board_array)
    @board_array  = board_array
    @column = nil
  end

  def drop(piece, column_number)
    # column_number = column_position # potential API-internal conversion
    empty_string = ''
    
    self.column = board_array.collect { |row| row[column_number] }
    pieces_in_column = column.select { |slot| slot unless slot == empty_string }

    if column.all?(empty_string)
      row_number = board_array.size - 1 
    else
      row_number = (column.size - pieces_in_column.size) - 1
    end

    board_array[row_number][column_number] = piece    
    column[row_number] = piece    
  end
end