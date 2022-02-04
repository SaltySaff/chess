# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'
require_relative '../lib/player'

# game = Game.new
# game.play_game

board = Board.new
game = Game.new
board.move_piece([1, 5], [2, 5])
board.move_piece([6, 4], [5, 4])
board.move_piece([1, 6], [3, 6])
board.move_piece([7, 3], [3, 7])

board.display
p board.check_counter




