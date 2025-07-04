# this file defines the Game class logic
class Game
  def initialize(player = nil, board = nil)
    @player = player
    @board = board
    @last_position = []
    @directions = [[0, 1], [1, 0], [1, 1], [1, -1]]
    @player_disc = nil
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
    loop do
      @board.display_board
      process_move

      # Checks if the last move resulted in a win.
      # Parameters: game board, last move's row and column, and the current player's disc.
      break if winning_move?(@board.board, @last_position[-1][0], @last_position[-1][1], @player_disc)
    end
  end

  def process_move
    player_input = @player.validate_player_input
    @player_disc = @player.player_move
    @last_position << @board.update_board(player_input, @player_disc)
  end

  # helper function to winning_move? to count 4 occurrences of discs
  def count_combination(board, row, col, delta_row, delta_col, player_disc) # rubocop:disable Metrics/ParameterLists
    count = 0
    current_row = row + delta_row
    current_col = col + delta_col

    while in_bounds?(board, current_row, current_col) &&
          board[current_row][current_col] == player_disc
      count += 1
      current_row += delta_row
      current_col += delta_col
    end

    count
  end

  # return true if the position is inbound the board
  def in_bounds?(board, row, col)
    row.between?(0, board.length - 1) &&
      col.between?(0, board[0].length - 1)
  end

  # this function is used to scan the board starting from the current position(the players chosen disc)
  def winning_move?(board, row, col, player_disc)
    # remove the top row for accurate board representation
    top_less_board = board[1..]

    # iterate through opposite directions simultaneously to count occurrences on both sides
    # then sum up both result with 1 (current disc) if 4 or greater is found, will return true
    @directions.any? do |delta_row, delta_col|
      total_count = 1 +
                    count_combination(top_less_board, row, col, delta_row, delta_col, player_disc) +
                    count_combination(top_less_board, row, col, -delta_row, -delta_col, player_disc)

      total_count >= 4
    end
  end
end
