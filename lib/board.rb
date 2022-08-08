class Board 
  attr_reader :board_array, :row, :column, :left_diagonal, :right_diagonal, :latest_placement_piece, :latest_placement_coordinates, :pieces_in_column

  def initialize(board_array = Array.new(6) { Array.new(7, '') })
    @board_array  = board_array
  end

  def display_board
    board_array.each { |row| puts "\t"; puts row.join("\t") }
  end

  def drop(piece, column_number)
    column_number -= 1

    collect_column(column_number)
    collect_pieces_already_in(column)

    return puts invalid_number_message unless column_number.between?(0, 6)
    return puts full_column_message if full_column?

    row_number = if column_empty?
                   last_row_number
                 else
                   row_number_before_occupied_row
                 end

    save_coordinates(row_number, column_number)
    board_array[row_number][column_number] = piece
  end

  def four_successive_pieces?
    collect_lines_of_pieces

    row_succession? || column_succession? || left_diagonal_succession? || right_diagonal_succession?
  end

  private

  def invalid_number_message
    'Invalid number (not between 1 and 7)'
  end

  def save_coordinates(row_number, column_number)
    @latest_placement_coordinates = { row_number:, column_number: }
  end

  def last_row_number
    board_array.size - 1
  end

  def row_number_before_occupied_row
    (column.size - pieces_in_column.size) - 1
  end

  def full_column?
    pieces_in_column.size == board_array.size
  end

  def full_column_message
    'The column is full. Please choose another column.'
  end

  def collect_column(column_number)
    @column = board_array.collect { |row| row[column_number] }
  end

  def collect_pieces_already_in(column)
    @pieces_in_column = column.select { |slot| slot unless slot == '' }
  end

  def collect_lines_of_pieces
    row_number    = latest_placement_coordinates[:row_number]
    column_number = latest_placement_coordinates[:column_number]

    @row = board_array[row_number]
    @column = board_array.collect { |row| row[column_number] }
    @left_diagonal  = lower_left_diagonal_collection  + upper_left_diagonal_collection
    @right_diagonal = lower_right_diagonal_collection + upper_right_diagonal_collection
  end

  def column_empty?
    column.all?('')
  end

  def row_succession?
    succession_piece_count = 1

    row.size.times do |index|
      return true if succession_piece_count == 4 && row[index] == row[index - 1]

      succession_piece_count += 1 if row[index] == row[index + 1] && row[index] == latest_placement_piece && row[index] != ''
    end

    return false
  end

  def column_succession?
    succession_piece_count = 1

    column.size.times do |index|
      current_slot = column[index]

      return true if succession_piece_count == 4 && current_slot == column[index - 1] && slot_occupied_at?(index)

      succession_piece_count += 1 if current_slot == column[index + 1] && current_slot == latest_placement_piece && slot_occupied_at?(index)
    end

    return false
  end

  def slot_occupied_at?(index)
    column[index] != ''
  end

  def diagonal_succession?
    left_diagonal_succession? || right_diagonal_succession?
  end

  def left_diagonal_succession?
    succession_piece_count = 1

    left_diagonal.size.times do |index|
      current_slot = left_diagonal[index]

      return true if succession_piece_count == 4 && current_slot == left_diagonal[index - 1]

      succession_piece_count += 1 if current_slot == left_diagonal[index + 1] && current_slot == latest_placement_piece
    end

    return false
  end

  def right_diagonal_succession?
    succession_piece_count = 1

    right_diagonal.size.times do |index|
      return true if succession_piece_count == 4 && right_diagonal[index] == right_diagonal[index - 1]

      succession_piece_count += 1 if right_diagonal[index] == right_diagonal[index + 1] && right_diagonal[index] == latest_placement_piece
    end

    return false
  end

  def upper_left_diagonal_collection
    row_index    = latest_placement_coordinates[:row_number]
    column_index = latest_placement_coordinates[:column_number]
    upper_left_diagonal = []

    return [board_array[row_index][column_index]] if board_array[row_index - 1][column_index + 1].nil?
    
    loop do
      current_slot_piece = board_array[row_index][column_index]
      upper_left_diagonal << current_slot_piece unless current_slot_piece.nil? || row_index.negative?

      row_index    -= 1
      column_index += 1

      break if current_slot_piece.nil? || (row_index - 1).negative?
    end

    return upper_left_diagonal
  end

  def lower_left_diagonal_collection
    row_index    = latest_placement_coordinates[:row_number]
    column_index = latest_placement_coordinates[:column_number]
    lower_left_diagonal = []
    next_row = board_array[row_index + 1]

    if next_row.nil? || next_row[column_index - 1].nil?
      lower_left_diagonal << board_array[row_index][column_index]
      lower_left_diagonal.reverse!.pop
      return lower_left_diagonal
    end

    loop do
      current_slot_piece = board_array[row_index][column_index] unless column_index.negative?
      lower_left_diagonal << current_slot_piece unless current_slot_piece.nil? || column_index.negative?

      row_index    += 1
      column_index -= 1

      break if current_slot_piece.nil? || row_index > board_array.size - 1
    end

    lower_left_diagonal.reverse!.pop

    return lower_left_diagonal
  end

  def lower_right_diagonal_collection
    reversed_board_array = board_array.reverse
    row_index    = (board_array.size - 1) - latest_placement_coordinates[:row_number] 
    column_index = latest_placement_coordinates[:column_number]
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
    row_index    = (board_array.size - 1) - latest_placement_coordinates[:row_number]
    return [] if (row_index - 1).negative?
    column_index = latest_placement_coordinates[:column_number]
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
