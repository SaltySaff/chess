# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

board = Board.ne
board.move_piece([1, 4], [2, 3])
board.display

