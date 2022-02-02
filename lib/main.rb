# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

board = Board.new
board.move_piece([1, 0], [3, 0])
board.move_piece([3, 0], [4, 0])
board.move_piece([6, 1], [5, 1])
board.move_piece([4, 0], [5, 1])
board.move_piece([0, 0], [6, 0])
board.display
