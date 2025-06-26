# this file defines the Game class logic
class Game
  def initialize(player, board)
    @player = player
    @board = board
  end

  def play_game
    puts game_intro
    @board.display_board
    run_game
  end

  def game_intro
    <<~TEXT
      🎯 Welcome to Connect Four!

      Two players take turns dropping their discs into a 7-column, 6-row grid.
      The first to connect four discs in a row — vertically, horizontally, or diagonally — wins!

      Let the game begin!
    TEXT
  end

  def run_game; end
end
