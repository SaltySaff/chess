# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

rook = Piece.new('queen', 'black')
p rook.moveset