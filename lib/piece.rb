# frozen_string_literal: true

class Piece
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
      @moveset = [1, 0].freeze
    when 'king'
      @moveset = [[1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1], [1, -1], [1, 0]].freeze
    end
  end