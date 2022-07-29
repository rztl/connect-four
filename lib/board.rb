class Board 
  attr_accessor :board_array,
                :row, 
                :column,
                :left_diagonal,
                :right_diagonal,
                :latest_placement_piece,
                :latest_placement_coordinates

  def initialize(board_array)
    @board_array  = board_array

    @row    = nil
    @column = nil

    @latest_placement_piece       = nil
    @latest_placement_coordinates = nil
  end

  def drop(piece, column_number)
    # column_number = column_position # potential API->internal conversion

    self.column = board_array.collect { |row| row[column_number] }
    pieces_in_column = column.select { |slot| slot unless slot == '' }

    if column.all?('')
      row_number = board_array.size - 1 
    else
      row_number = (column.size - pieces_in_column.size) - 1
    end

    board_array[row_number][column_number] = piece
    column[row_number] = piece
  end

  def four_successive_pieces?
    row_number    = latest_placement_coordinates[0]
    column_number = latest_placement_coordinates[1]
    reversed_board_array = board_array.reverse
    self.row = board_array[row_number]
    self.column = board_array.collect { |row| row[column_number] }
    self.left_diagonal  = lower_left_diagonal_collection  + upper_left_diagonal_collection
    self.right_diagonal = lower_right_diagonal_collection + upper_right_diagonal_collection
    
    row_succession? || column_succession? || left_diagonal_succession? || right_diagonal_succession?
  end
  





  
  # private

  # def row_succession?
  #   succession_piece_count = 0

  #   row.size.times do |index|
  #     succession_piece_count += 1 if row[index] == row[index + 1] && row[index] != '' || row[index] == row.last 

  #     break if index + 1 == row.size
  #     break if succession_piece_count == 4

  #     return false if row[index] != row[index + 1] && row[index] != ''
  #   end

  #   return false if succession_piece_count != 4
  #   return true 
  # end

  def row_succession?
    succession_piece_count = 1

    row.size.times do |index|
      return true if succession_piece_count == 4 && row[index] == row[index - 1]

      succession_piece_count += 1 if row[index] == row[index + 1] && row[index] != ''
    end

    return false
  end

  # def column_succession?
  #   succession_piece_count = 0

  #   column.size.times do |index|
  #     succession_piece_count += 1 if column[index] == column[index + 1] && column[index] != '' || column[index] == column.last 

  #     break if index + 1 == column.size
  #     break if succession_piece_count == 4

  #     return false if column[index] != column[index + 1] && column[index] != ''
  #   end

  #   return false if succession_piece_count != 4
  #   return true 
  # end

  def column_succession?
    succession_piece_count = 1

    column.size.times do |index|
      return true if succession_piece_count == 4 && column[index] == column[index - 1] && column[index] != ''

      succession_piece_count += 1 if column[index] == column[index + 1] && column[index] != ''
    end

    return false
  end



  def diagonal_succession?
    left_diagonal_succession? || right_diagonal_succession?
  end



  # def left_diagonal_succession?
  #   succession_piece_count = 0

  #   left_diagonal.size.times do |index|
  #     succession_piece_count += 1 if left_diagonal[index] == left_diagonal[index + 1] && left_diagonal[index] != '' || left_diagonal[index] == left_diagonal.last 

  #     break if index + 1 == left_diagonal.size
  #     break if succession_piece_count == 4

  #     return false if left_diagonal[index] != left_diagonal[index + 1] && left_diagonal[index] != '' && succession_piece_count != 4
  #   end

  #   # return false if succession_piece_count != 4
  #   return true 
  # end

  def left_diagonal_succession?
    succession_piece_count = 1

    left_diagonal.size.times do |index|
      return true if succession_piece_count == 4 && left_diagonal[index] == left_diagonal[index - 1]

      succession_piece_count += 1 if left_diagonal[index] == left_diagonal[index + 1] && left_diagonal[index] != ''
    end

    return false
  end

  def right_diagonal_succession?
    succession_piece_count = 1

    right_diagonal.size.times do |index|
      return true if succession_piece_count == 4 && right_diagonal[index] == right_diagonal[index - 1]

      succession_piece_count += 1 if right_diagonal[index] == right_diagonal[index + 1] && right_diagonal[index] != ''
    end

    return false
  end



  def upper_left_diagonal_collection
    row_index    = latest_placement_coordinates[0]
    column_index = latest_placement_coordinates[1]
    upper_left_diagonal = []

    return [board_array[row_index][column_index]] if board_array[row_index - 1][column_index + 1].nil?
    
    loop do
      current_slot_piece = board_array[row_index][column_index]
      upper_left_diagonal << current_slot_piece unless current_slot_piece.nil? || row_index.negative?

      row_index    -= 1
      column_index += 1

      break if current_slot_piece.nil?
    end

    return upper_left_diagonal
  end

  def lower_left_diagonal_collection
    row_index    = latest_placement_coordinates[0]
    column_index = latest_placement_coordinates[1]
    lower_left_diagonal = []

    if board_array[row_index + 1].nil? || board_array[row_index + 1][column_index - 1].nil?
      lower_left_diagonal << board_array[row_index][column_index]
      lower_left_diagonal.reverse!.pop
      return lower_left_diagonal
    end
    loop do
      current_slot_piece = board_array[row_index][column_index] unless column_index.negative?
      lower_left_diagonal << current_slot_piece unless current_slot_piece.nil? || column_index.negative?

      row_index    += 1
      column_index -= 1

      break if current_slot_piece.nil?
    end

    lower_left_diagonal.reverse!.pop

    return lower_left_diagonal
  end




  
  def lower_right_diagonal_collection
    reversed_board_array = board_array.reverse
    row_index    = (board_array.size - 1) - latest_placement_coordinates[0] 
    column_index = latest_placement_coordinates[1]
    lower_right_diagonal = []

    if reversed_board_array[row_index + 1].nil? || reversed_board_array[row_index + 1][column_index - 1].nil?
      lower_right_diagonal << reversed_board_array[row_index][column_index]
      lower_right_diagonal.reverse!.pop
      return lower_right_diagonal
    end
    loop do
      current_slot_piece = reversed_board_array[row_index][column_index] unless column_index.negative? || row_index == board_array.size
    
      lower_right_diagonal << current_slot_piece unless current_slot_piece.nil? || column_index.negative?

      row_index    += 1
      column_index -= 1

      break if current_slot_piece.nil?
    end

    lower_right_diagonal.reverse!.pop

    return lower_right_diagonal
  end

  def upper_right_diagonal_collection
    reversed_board_array = board_array.reverse
    row_index    = (board_array.size - 1) - latest_placement_coordinates[0] 
    column_index = latest_placement_coordinates[1]
    upper_right_diagonal = []
  
    return [reversed_board_array[row_index][column_index]] if reversed_board_array[row_index - 1][column_index + 1].nil?
    
    loop do
      current_slot_piece = reversed_board_array[row_index][column_index]
      upper_right_diagonal << current_slot_piece unless current_slot_piece.nil? || row_index.negative?
  
      row_index    -= 1
      column_index += 1
  
      break if current_slot_piece.nil?
    end
  
    return upper_right_diagonal
  end

end


#=======================================================


# board_array = 
# [
#   ['' , '' , '' ,  'x'  , '', '', ''],
#   ['' , '' , '' ,  'o'  ,'x', '', ''],
#   ['' , '' , '' ,  'x' , 'x', 'x', ''],
#   ['' , '' , 'x' , 'o' , 'o', 'o', 'x'],
#   ['' , 'o' ,'o' , 'x' , 'x', 'x', 'o'],
#   ['x' ,'o' ,'o' , 'x' , 'o', 'x', 'x'],

# ]

# reversed_board_array = [
#   ["x", "o", "o", "x", "o", "x", "x"],
#   ["", "o", "o", "x", "x", "x", "o"],
#   ["", "", "x", "o", "o", "o", "x"],
#   ["", "", "", "x", "x", "x", ""],
#   ["", "", "", "o", "x", "", ""],
#   ["", "", "", "x", "", "", ""]
# ]

# board = Board.new(board_array)
# board.latest_placement_coordinates = [1, 4]
# board.latest_placement_piece = 'x'

# pp board_array.reverse

# p board.four_successive_pieces?


