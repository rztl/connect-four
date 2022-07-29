require_relative '../lib/board'

describe Board do
  describe '#drop' do
		context 'when there are no pieces on the chosen column' do
			it 'drops the piece to the bottom of the board' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['o', 'o', '' , '' , '', '', '']
				]
				expected_board_array =
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['o', 'o', 'o', '' , '', '', '']
				] 
				board = described_class.new(board_array)
	
				board.drop('o', 2)
	
				expect(board.board_array).to eq(expected_board_array)
			end
		end

		context 'when there are inserted pieces on the chosen column' do
			it 'drops the piece above the top pre-inserted piece' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['x' , '' , '' , '' , '', '', ''],
					['x' , '' , '' , '' , '', '', ''],
					['o', '' , '' , '' , '', '', ''],
					['o', '' , '' , '' , '', '', '']
				]
				# expected_board_array =
				# [
				# 	['' , '' , '' , '' , '', '', ''],
				# 	['' , '' , '' , '' , '', '', ''],
				# 	['' , '' , '' , '' , '', '', ''],
				# 	['x' , '' , '' , '' , '', '', ''],
				# 	['o', '' , '' , '' , '', '', ''],
				# 	['o', '' , '' , '' , '', '', '']
				# ]

				expected_column = ['', 'x', 'x', 'x', 'o', 'o']
				board = described_class.new(board_array)
	
				board.drop('x', 0)
	
				expect(board.column).to eq(expected_column)
			end
		end
	end

	describe '#four_successive_pieces' do
		context 'when the succession chain is a row' do
			it 'returns true for that piece' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['', '', '' ,'o' , 'o', 'o', 'o']
				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [5, 3]
				board.latest_placement_piece = 'o'
			
				expect(board.four_successive_pieces?).to be true
			end

			it 'returns false otherwise' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['o', 'o', 'x' ,'o' , 'x', 'o', 'x']
				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [5, 2]
				board.latest_placement_piece = 'o'
			
				expect(board.four_successive_pieces?).to be false
			end

			
		end

		context 'when the succession chain is a column' do
			it 'returns true for that piece' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['x' , '' , '' , '' , '', '', ''],
					['x' , '' , '' , '' , '', '', ''],
					['x' , '' , '' , '' , '', '', ''],
					['x', '', '' ,'' , '', '', '']
				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [2, 0]
				board.latest_placement_piece = 'x'
			
				expect(board.four_successive_pieces?).to be true
			end

			it 'returns false otherwise' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', '']
				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [3, 1]
				board.latest_placement_piece = 'x'
			
				expect(board.four_successive_pieces?).to be false
			end

			
		end

		context 'when the succession chain is a left diagonal' do
			it 'returns true for that piece' do
				board_array = 
				[
					['' , '' , '' ,  ''  , '', '', ''],
					['' , '' , '' ,  ''  , '', '', ''],
					['' , '' , '' ,  'x' , '', '', ''],
					['' , '' , 'x' , 'o' , '', '', ''],
					['' , 'x' ,'o' , 'x' , '', '', ''],
					['x' ,'o' ,'o' , 'x' , '', '', ''],

				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [2, 3]
				board.latest_placement_piece = 'x'
			
				expect(board.four_successive_pieces?).to be true
			end

			it 'returns false otherwise' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', '']
				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [3, 1]
				board.latest_placement_piece = 'x'
			
				expect(board.four_successive_pieces?).to be false
			end

			
		end

		context 'when the succession chain is a right diagonal' do
			it 'returns true for that piece' do
				board_array = 
				[
					['' , '' , '' ,  'x'  , '', '', ''],
					['' , '' , '' ,  'o'  ,'x', '', ''],
					['' , '' , '' ,  'x' , 'x', 'x', ''],
					['' , '' , 'x' , 'o' , 'o', 'o', 'x'],
					['' , 'o' ,'o' , 'x' , 'x', 'x', 'o'],
					['x' ,'o' ,'o' , 'x' , 'o', 'x', 'x'],

				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [0, 3]
				board.latest_placement_piece = 'x'
			
				expect(board.four_successive_pieces?).to be true
			end

			it 'returns false otherwise' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', '']
				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = [3, 1]
				board.latest_placement_piece = 'x'
			
				expect(board.four_successive_pieces?).to be false
			end

			
		end
	end
end
