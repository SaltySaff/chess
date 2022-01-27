# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

rook = Piece.new('rook', 'white')
p rook.icon

# board = Board.new
# board.display
