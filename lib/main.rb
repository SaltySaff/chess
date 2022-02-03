# frozen_string_literal: true

require 'colorize'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'
require_relative '../lib/player'

# game = Game.new
# game.play_game
board = Board.new
board.display
