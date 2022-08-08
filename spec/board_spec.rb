require_relative '../lib/board'

describe Board do
  describe '#drop' do
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

        board.drop('o', 3)

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
            ['', 'q', 'q' , '' , '', '', '']
          ]
          expected_board_array =
          [
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['q', 'q', 'q', '' , '', '', '']
          ] 
          board = described_class.new(board_array)

          board.drop('q', 1)

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
            ['', 'w', 'w' , '' , '', '', '']
          ]
          expected_board_array =
          [
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['', 'w', 'w', '' , '', '', 'w']
          ]
          board = described_class.new(board_array)

          board.drop('w', 7)

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
          ['' , 'e' , '' , '' , '', '', ''],
          ['' , 'e' , '' , '' , '', '', ''],
          ['',  'R' , '' , '' , '', '', ''],
          ['',  'R' , '' , '' , '', '', '']
        ]
        expected_board_array = 
        [
          ['' , '' , '' , '' , '', '', ''],
          ['' , 'e' , '' , '' , '', '', ''],
          ['' , 'e' , '' , '' , '', '', ''],
          ['' , 'e' , '' , '' , '', '', ''],
          ['',  'R' , '' , '' , '', '', ''],
          ['',  'R' , '' , '' , '', '', '']
        ]
        board = described_class.new(board_array)

        board.drop('e', 2)

        expect(board.board_array).to eq(expected_board_array)
      end

      context 'considering edge cases' do
        it 'drops piece above the pre-inserted piece if in the first column' do
          board_array = 
          [
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', ''],
            ['a' , '' , '' , '' , '', '', ''],
            ['a' , '' , '' , '' , '', '', ''],
            ['4', '' , '' , '' , '', '', ''],
            ['4', '' , '' , '' , '', '', '']
          ]
          expected_board_array = 
          [
            ['' , '' , '' , '' , '', '', ''],
            ['a' , '' , '' , '' , '', '', ''],
            ['a' , '' , '' , '' , '', '', ''],
            ['a' , '' , '' , '' , '', '', ''],
            ['4', '' , '' , '' , '', '', ''],
            ['4', '' , '' , '' , '', '', '']
          ]
          board = described_class.new(board_array)

          board.drop('a', 1)

          expect(board.board_array).to eq(expected_board_array)
        end

        it 'drops piece above the pre-inserted piece if in the last column' do
          board_array = 
          [
            ['' , '' , '' , '' , '', '', ''],
            ['' , '' , '' , '' , '', '', '1'],
            ['' , '' , '' , '' , '', '', '1'],
            ['' , '' , '' , '' , '', '', '1'],
            ['', '' , '' , '' , '', '',  '2'],
            ['', '' , '' , '' , '', '',  '2']
          ]
          expected_board_array =
          [
            ['' , '' , '' , '' , '', '', '1'],
            ['' , '' , '' , '' , '', '', '1'],
            ['' , '' , '' , '' , '', '', '1'],
            ['' , '' , '' , '' , '', '', '1'],
            ['', '' , '' , '' , '', '',  '2'],
            ['', '' , '' , '' , '', '',  '2']
          ]
          board = described_class.new(board_array)

          board.drop('1', 7)

          expect(board.board_array).to eq(expected_board_array)
        end

        it 'sends rectifying display message if column is full' do
          board_array = 
          [
            ['' , '' , '' , '0' , '', '', ''],
            ['' , '' , '' , '0' , '', '', ''],
            ['' , '' , '' , 'o' , '', '', ''],
            ['' , '' , '' , '0' , '', '', ''],
            ['' , '' , '' , 'o' , '', '', ''],
            ['' , '' , '' , 'o' , '', '', ''],
          ]

          board = described_class.new(board_array)

          expect(board).to receive(:puts)
          board.drop('o', 4)
        end
      end
    end
    
    context 'when given an out-of-bound value' do
      it 'displays a message of invalidity' do
        board = described_class.new

        expect(board).to receive(:puts).with('Invalid number (not between 1 and 7)')
        board.drop('4', 100)
      end
    end
  end

  describe '#four_successive_pieces?' do
    context 'when the succession chain is a row' do
      it 'returns true for that piece' do
        board_array = 
        [
          ['' , '' , '' , '' , '', '', '' ],
          ['' , '' , '' , '' , '', '', '' ],
          ['' , '' , '' , '' , '', '', '' ],
          ['' , '' , '' , '' , '', '', '' ],
          ['' , '' , '' , '' , '', '', '' ],
          ['', '', '' ,'🔶' , '🔶', '🔶', '🔶']
        ]
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_coordinates, row_number: 5, column_number: 3
        board.instance_variable_set :@latest_placement_piece, '🔶'

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
          ['🔶', '🔶', '🔷' ,'🔶' , '🔷', '🔶', '🔷']
        ]
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_coordinates, row_number: 5, column_number: 2
        board.instance_variable_set :@latest_placement_piece, '🔷'


        expect(board.four_successive_pieces?).to be false
      end


    end

    context 'when the succession chain is a column' do
      it 'returns true for that piece' do
        board_array = 
        [
          ['' , '' , '' , '' , '', '', ''],
          ['' , '' , '' , '' , '', '', ''],
          ['🔷' , '' , '' , '' , '', '', ''],
          ['🔷' , '' , '' , '' , '', '', ''],
          ['🔷' , '' , '' , '' , '', '', ''],
          ['🔷', '', '' ,'' , '', '', '']
        ]
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_coordinates, row_number: 2, column_number: 0
        board.instance_variable_set :@latest_placement_piece, '🔷'

        

        expect(board.four_successive_pieces?).to be true
      end

      it 'returns false otherwise' do
        board_array = 
        [
          ['' , '' , '' , '' , '', '', ''],
          ['' , '' , '' , '' , '', '', ''],
          ['' , '🔷' , '' , '' , '', '', ''],
          ['' , '🔺' , '' , '' , '', '', ''],
          ['' , '🔷' , '' , '' , '', '', ''],
          ['' , '🔷' , '' , '' , '', '', '']
        ]
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_coordinates, row_number: 2, column_number: 1
        board.instance_variable_set :@latest_placement_piece, '🔷'


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
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_piece, 'x'
        board.instance_variable_set :@latest_placement_coordinates, row_number: 2, column_number: 3
        
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
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_piece, 'x'
        board.instance_variable_set :@latest_placement_coordinates, row_number: 3, column_number: 1
     
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
          board = described_class.new(board_array)
          board.instance_variable_set :@latest_placement_piece, 'x'
          board.instance_variable_set :@latest_placement_coordinates, row_number: 5, column_number: 0

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
          board = described_class.new(board_array)
          board.instance_variable_set :@latest_placement_piece, 'o'
          board.instance_variable_set :@latest_placement_coordinates, row_number: 0, column_number: 6

          expect(board.four_successive_pieces?).to be false
        end
      end
    end

    context 'when the succession chain is a right diagonal' do
      it 'returns true for that piece' do
        board_array = 
        [
          ['' , '' , '' ,  '🔷'  , '', '', ''],
          ['' , '' , '' ,  '🔺'  ,'🔷', '', ''],
          ['' , '' , '' ,  '🔷' , '🔷', '🔷', ''],
          ['' , '' , '🔷' , '🔺' , '🔺', '🔺', '🔷'],
          ['' , '🔺' ,'🔺' , '🔷' , '🔷', '🔷', '🔺'],
          ['🔺' ,'🔺' ,'🔺' , '🔷' , '🔺', '🔷', '🔷'],

        ]
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_coordinates, row_number: 0, column_number: 3
        board.instance_variable_set :@latest_placement_piece, '🔷'

     
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
        board = described_class.new(board_array)
        board.instance_variable_set :@latest_placement_coordinates, row_number: 3, column_number: 1

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
          board = described_class.new(board_array)
          board.instance_variable_set :@latest_placement_coordinates, row_number: 5, column_number: 6

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
          board = described_class.new(board_array)
          board.instance_variable_set :@latest_placement_coordinates, row_number: 0, column_number: 0

          expect(board.four_successive_pieces?).to be false
        end
      end
    end
  end
end
