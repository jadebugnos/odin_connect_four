require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/board'
require 'pry-byebug'

player = Player.new
board = GameBoard.new
game = Game.new(player, board)

game.play_game
