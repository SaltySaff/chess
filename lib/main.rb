# frozen_string_literal: true

require 'colorize'
require 'yaml'

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/piece'
require_relative '../lib/player'

game = Game.new
game.play_game

