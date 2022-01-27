# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

# rook = Piece.new('queen', 'black')
# p rook.moveset

board = Board.new
board.display
