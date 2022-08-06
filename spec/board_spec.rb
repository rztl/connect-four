require_relative '../lib/board'

describe Board do
  xdescribe '#drop' do
		context 'when there are no pieces on the chosen column' do
			it 'drops piece to the bottom of the board' do
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

			context 'considering edge cases' do
				it 'drops piece to the bottom of the first column' do
					board_array = 
					[
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['', 'o', 'o' , '' , '', '', '']
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
		
					board.drop('o', 0)
		
					expect(board.board_array).to eq(expected_board_array)
				end
	
				it 'drops piece to the bottom of the last column' do
					board_array = 
					[
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['', 'o', 'o' , '' , '', '', '']
					]
					expected_board_array =
					[
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['', 'o', 'o', '' , '', '', 'o']
					] 
					board = described_class.new(board_array)
		
					board.drop('o', 6)
		
					expect(board.board_array).to eq(expected_board_array)
				end
			end
			
		end

		context 'when there are inserted pieces on the chosen column' do
			it 'drops piece above the pre-inserted pieces' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['',  'o' , '' , '' , '', '', ''],
					['',  'o' , '' , '' , '', '', '']
				]
				expected_board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['',  'o' , '' , '' , '', '', ''],
					['',  'o' , '' , '' , '', '', '']
				]
				board = described_class.new(board_array)
	
				board.drop('x', 1)

				expect(board.board_array).to eq(expected_board_array)
			end

			context 'considering edge cases' do
				it 'drops piece above the pre-inserted piece if in the first column' do
					board_array = 
					[
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', ''],
						['x' , '' , '' , '' , '', '', ''],
						['x' , '' , '' , '' , '', '', ''],
						['o', '' , '' , '' , '', '', ''],
						['o', '' , '' , '' , '', '', '']
					]
					expected_board_array = 
					[
						['' , '' , '' , '' , '', '', ''],
						['x' , '' , '' , '' , '', '', ''],
						['x' , '' , '' , '' , '', '', ''],
						['x' , '' , '' , '' , '', '', ''],
						['o', '' , '' , '' , '', '', ''],
						['o', '' , '' , '' , '', '', '']
					]
					board = described_class.new(board_array)
		
					board.drop('x', 0)
		
					expect(board.board_array).to eq(expected_board_array)
				end

				it 'drops piece above the pre-inserted piece if in the last column' do
					board_array = 
					[
						['' , '' , '' , '' , '', '', ''],
						['' , '' , '' , '' , '', '', 'x'],
						['' , '' , '' , '' , '', '', 'x'],
						['' , '' , '' , '' , '', '', 'x'],
						['', '' , '' , '' , '', '',  'o'],
						['', '' , '' , '' , '', '',  'o']
					]
					expected_board_array = 
					[
						['' , '' , '' , '' , '', '', 'x'],
						['' , '' , '' , '' , '', '', 'x'],
						['' , '' , '' , '' , '', '', 'x'],
						['' , '' , '' , '' , '', '', 'x'],
						['', '' , '' , '' , '', '',  'o'],
						['', '' , '' , '' , '', '',  'o']
					]
					board = described_class.new(board_array)
		
					board.drop('x', 6)
		
					expect(board.board_array).to eq(expected_board_array)
				end

				it 'sends rectifying display message if column is full' do
					board_array = 
					[
						['' , '' , '' , 'o' , '', '', ''],
						['' , '' , '' , 'o' , '', '', ''],
						['' , '' , '' , 'x' , '', '', ''],
						['' , '' , '' , 'o' , '', '', ''],
						['' , '' , '' , 'x' , '', '', ''],
						['' , '' , '' , 'x' , '', '', ''],
					]

					board = described_class.new(board_array)

					expect(board).to receive(:puts)
					board.drop('x', 3)
				end
			end
		end
	end

	describe '#four_successive_pieces?' do
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
				board.latest_placement_piece = 'o'
				board.latest_placement_coordinates = { row_number: 5, column_number: 3 }
			
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
				board.latest_placement_piece = 'o'
				board.latest_placement_coordinates = { row_number: 5, column_number: 2 } 
			
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
				board.latest_placement_piece = 'x'
				board.latest_placement_coordinates = { row_number: 2, column_number: 0 }
			
				expect(board.four_successive_pieces?).to be true
			end

			it 'returns false otherwise' do
				board_array = 
				[
					['' , '' , '' , '' , '', '', ''],
					['' , '' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'o' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', ''],
					['' , 'x' , '' , '' , '', '', '']
				]
				board = Board.new(board_array)
				board.latest_placement_coordinates = { row_number: 2, column_number: 1 }
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
				board.latest_placement_piece = 'x'
				board.latest_placement_coordinates = { row_number: 2, column_number: 3 }
			
				expect(board.four_successive_pieces?).to be true
			end

			it 'returns false otherwise' do
				board_array = 
				[
					['' , '' ,  '' ,  '' , '', '', ''],
					['' , '' ,  '' ,  '' , '', '', ''],
					['' , '' ,  '' ,  'x' , '', '', ''],
					['' , 'x' , 'x' , 'o' , '', '', ''],
					['' , 'x' , 'o' , 'x' , '', '', ''],
					['o' ,'x' , 'o' , 'o' , '', '', '']
				]
				board = Board.new(board_array)
				board.latest_placement_piece = 'x'
				board.latest_placement_coordinates = { row_number: 3, column_number: 1 }
			
				expect(board.four_successive_pieces?).to be false
			end

			context 'considering left diagonal edge cases' do
				it 'returns false when piece is at bottom-left of board' do
					board_array = 
					[
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['x' , '' ,  '' ,  '' , '', '', ''],
					]
					board = Board.new(board_array)
					board.latest_placement_piece = 'x'
					board.latest_placement_coordinates = { row_number: 5, column_number: 0 }
				
					expect(board.four_successive_pieces?).to be false
				end

				it 'returns false when piece is at top-right of board' do
					board_array = 
					[
						['' , '' ,  '' ,  '' , '', '', 'o'],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
					]
					board = Board.new(board_array)
					board.latest_placement_piece = 'o'
					board.latest_placement_coordinates = { row_number: 0, column_number: 6 }
				
					expect(board.four_successive_pieces?).to be false
				end
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
				board.latest_placement_piece = 'x'
				board.latest_placement_coordinates = { row_number: 0, column_number: 3 }
			
				expect(board.four_successive_pieces?).to be true
			end

			it 'returns false otherwise' do
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
				board.latest_placement_piece = 'x'
				board.latest_placement_coordinates = { row_number: 3, column_number: 1 }
			
				expect(board.four_successive_pieces?).to be false
			end

			context 'considering right diagonal edge cases' do
				it 'returns false when piece is at bottom-right of board' do
					board_array = 
					[
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', 'x'],
					]
					board = Board.new(board_array)
					board.latest_placement_piece = 'x'
					board.latest_placement_coordinates = { row_number: 5, column_number: 6 }
				
					expect(board.four_successive_pieces?).to be false
				end

				it 'returns false when piece is at top-left of board' do
					board_array = 
					[
						['o' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
						['' , '' ,  '' ,  '' , '', '', ''],
					]
					board = Board.new(board_array)
					board.latest_placement_piece = 'o'
					board.latest_placement_coordinates = { row_number: 0, column_number: 0 }
				
					expect(board.four_successive_pieces?).to be false
				end
			end
		end
	end
end
