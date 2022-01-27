# frozen_string_literal: true

# creates/modifies game board
class Board
  def initialize
    @board_cells = Array.new(8) { Array.new(8, ' ') }
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
    @board_cells.each do |row|
    end
  end

  def get_piece_location(piece_type, color)
    locations = {
      'pawn' => { 'black' => populate_pawns([6, 0]), 'white' => populate_pawns([1, 0]) },
      'knight' => { 'black' => [[7, 1], [7, 6]], 'white' => [[0, 1], [0, 6]] },
      'king' => { 'black' => [[7, 3]], 'white' => [[0, 3]] },
      'rook' => { 'black' => [[7, 0], [7, 7]], 'white' => [[0, 0], [0, 7]] },
      'bishop' => { 'black' => [[7, 2]], 'white' => [[7, 5]] },
      'queen' => { 'black' => [[7, 4]], 'white' => [[0, 4]] }
    }
    locations[piece_type][color]
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
