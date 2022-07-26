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

	it 'updates as oooo on last row' 
	it 'returns winning message' 
	it 'returns losing message'
end
