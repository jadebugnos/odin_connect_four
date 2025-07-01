# this file defines the Game class logic
class Game
  def initialize(player = nil, board = nil)
    @player = player
    @board = board
    @game_state = false
  end

  def play_game
    puts game_intro
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

  def run_game
    until game_over?
      @board.display_board
      process_move
    end
  end

  def process_move
    player_input = @player.validate_player_input
    player_disc = @player.player_move
    @board.update_board(player_input, player_disc)
  end

  def game_over?
    false
  end
end
