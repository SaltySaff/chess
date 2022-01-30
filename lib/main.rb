# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

board = Board.new
board.move_piece([1, 4], [2, 4])
board.move_piece([2, 4], [3, 4])
board.move_piece([0, 4], [1, 4])
board.move_piece([1, 4], [2, 4])
board.display

