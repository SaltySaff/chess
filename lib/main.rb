# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

board = Board.new
board.display
board.move_piece([7, 0], [1, 0])
board.move_piece([0, 0], [1, 0])
board.display
p board.inactive_pieces.length
