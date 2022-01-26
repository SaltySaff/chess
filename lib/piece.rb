# frozen_string_literal: true

class Piece
  def initialize(piece_type, color)
    @piece_type = piece_type
    @color = color
    moveset = get_moveset(piece_type)
    active = true
  end

  def get_moveset(piece_type)
    case piece_type
    end
  end