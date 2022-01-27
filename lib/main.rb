# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'

board = Board.new
p board.populate_pawns([1, 0])
