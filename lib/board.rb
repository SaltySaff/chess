# frozen_string_literal: true

# creates/modifies game board
class Board
  def initialize
    @board_cells = Array.new(8) { Array.new(8, ' ') }
    @active_pieces = []
    generate_pieces
  end

  def display
    puts '  +---+---+---+---+---+---+---+---+'.light_blue
    n = 8
    while n >= 1
      puts "#{n.to_s.green} #{'|'.blue} #{@board_cells[n - 1].join(' | '.light_blue)} #{'|'.light_blue}"
      puts '  +---+---+---+---+---+---+---+---+'.light_blue
      n -= 1
    end
    puts '    a   b   c   d   e   f   g   h'.green
  end

  def generate_pieces
    create_pieces
    place_pieces
  end

  def create_pieces
    pieces = %w[pawn knight king rook bishop queen]
    colors = %w[black white]
    pieces.each do |piece|
      n = 0
      piece_locations[piece][colors[0]].length.times do
        @active_pieces << Piece.new(piece, colors[0], piece_locations[piece][colors[0]][n])
        @active_pieces << Piece.new(piece, colors[1], piece_locations[piece][colors[1]][n])
        n += 1
      end
    end
  end

  def place_pieces
    @active_pieces.each do |piece|
      @board_cells[piece.position[0]][piece.position[1]] = piece.icon
    end
  end

  def piece_locations
    {
      'pawn' => { 'black' => populate_pawns([6, 0]), 'white' => populate_pawns([1, 0]) },
      'knight' => { 'black' => [[7, 1], [7, 6]], 'white' => [[0, 1], [0, 6]] },
      'king' => { 'black' => [[7, 3]], 'white' => [[0, 3]] },
      'rook' => { 'black' => [[7, 0], [7, 7]], 'white' => [[0, 0], [0, 7]] },
      'bishop' => { 'black' => [[7, 2], [7, 5]], 'white' => [[0, 2], [0, 5]] },
      'queen' => { 'black' => [[7, 4]], 'white' => [[0, 4]] }
    }
  end

  def populate_pawns(initial_position)
    locations = []
    n = 0
    while n <= 7
      locations << [initial_position[0], initial_position[1] + n]
      n += 1
    end
    locations
  end
end
