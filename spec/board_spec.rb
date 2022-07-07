require './lib/board'

describe Board do
  it 'updates as oooo on first row' do
    board_instance = Board.new
    board_instance.board = [
      ['o', 'o', 'o', '', '', '', ''],
      ['' , '' , '' , '' , '', '', ''],
      ['' , '' , '' , '' , '', '', ''],
      ['' , '' , '' , '' , '', '', ''],
      ['' , '' , '' , '' , '', '', ''],
      ['' , '' , '' , '' , '', '', '']
    ]
    piece = 'o'
    coordinates = [0, 3]

    board_instance.drop(piece, coordinates)
    updated_board = board_instance.board

    expect(updated_board).to eq(
      [
        ['o', 'o', 'o', 'o', '', '', ''],
        ['' , '' , '' , '' , '', '', ''],
        ['' , '' , '' , '' , '', '', ''],
        ['' , '' , '' , '' , '', '', ''],
        ['' , '' , '' , '' , '', '', ''],
        ['' , '' , '' , '' , '', '', '']
      ] 
    )
  end
end