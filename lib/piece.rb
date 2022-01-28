# frozen_string_literal: true

# creates/controls chess pieces
class Piece
  attr_reader :piece_type, :moveset, :icon, :position

  def initialize(piece_type, color, position)
    @piece_type = piece_type
    @color = color
    @moveset = get_moveset(piece_type)
    @active = true
    @position = position
    @icon = get_icon(piece_type, color)
  end

  def get_moveset(piece_type)
    movesets = {
      'pawn' => [[1, 0]].freeze,
      'knight' => [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze,
      'king' => [[1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1], [1, -1], [1, 0]].freeze,
      'rook' => generate_moveset([[0, 1], [-1, 0], [0, -1], [1, 0]]).freeze,
      'bishop' => generate_moveset([[1, 1], [-1, 1], [-1, -1], [1, -1]]).freeze,
      'queen' => generate_moveset([[1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1], [1, -1], [1, 0]]).freeze
    }
    movesets[piece_type]
  end

  def generate_moveset(move_array)
    generated_moveset = []
    count = 1
    move_array.each do |move|
      count = 1
      7.times do
        generated_moveset << [[move[0] * count, move[1] * count]]
        count += 1
      end
    end
    generated_moveset
  end

  def get_icon(piece_type, color)
    icons = {
      'pawn' => { 'black' => "\u{2659}", 'white' => "\u{265F}" },
      'knight' => { 'black' => "\u{2658}", 'white' => "\u{265E}" },
      'king' => { 'black' => "\u{2654}", 'white' => "\u{265A}" },
      'rook' => { 'black' => "\u{2656}", 'white' => "\u{265C}" },
      'bishop' => { 'black' => "\u{2657}", 'white' => "\u{265D}" },
      'queen' => { 'black' => "\u{2655}", 'white' => "\u{265B}" }
    }
    icons[piece_type][color]
  end

  def get_location(piece_type, color)
    locations = {
      'pawn' => { 'black' => calc_location([6, 0], 8), 'white' => calc_location([1, 0], 8) },
      'knight' => { 'black' => "\u{2658}", 'white' => "\u{265E}" },
      'king' => { 'black' => "\u{2654}", 'white' => "\u{265A}" },
      'rook' => { 'black' => "\u{2656}", 'white' => "\u{265C}" },
      'bishop' => { 'black' => "\u{2657}", 'white' => "\u{265D}" },
      'queen' => { 'black' => "\u{2655}", 'white' => "\u{265B}" }
    }
    locations[piece_type][color]
  end
end