# frozen_string_literal: true

class Piece
  attr_reader :moveset

  def initialize(piece_type, color)
    @piece_type = piece_type
    @color = color
    @moveset = get_moveset(piece_type)
    @active = true
  end

  def get_moveset(piece_type)
    case piece_type
    when 'knight'
      @moveset = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].freeze
    when 'pawn'
      @moveset = [[1, 0]].freeze
    when 'king'
      @moveset = [[1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1], [1, -1], [1, 0]].freeze
    when 'rook'
      generate_moveset([[0, 1], [-1, 0], [0, -1], [1, 0]]).freeze
    when 'bishop'
      generate_moveset([[1, 1], [-1, 1], [-1, -1], [1, -1]]).freeze
    when 'queen'
      generate_moveset([[1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1], [1, -1], [1, 0]]).freeze
    end
  end

  def generate_moveset(move_array)
    p move_array
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
end