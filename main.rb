require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/board'

player = Player.new
board = GameBoard.new
game = Game.new(player, board)
game.play_game
