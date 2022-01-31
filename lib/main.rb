# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

board = Board.new
board.move_piece([6, 0], [4, 0])
board.move_piece([4, 0], [2, 0])
board.display

