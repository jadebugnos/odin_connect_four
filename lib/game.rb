# this file defines the Game class logic
class Game
  def initialize(player = nil, board = nil)
    @player = player                       # player object (handles input and disc choice)
    @board = board                         # board object (handles rendering and updates)
    @last_position = []                    # stores the last placed disc's position
    @directions = [[0, 1], [1, 0], [1, 1], [1, -1]] # directions to check for a win (horizontal, vertical, diagonal)
    @player_disc = nil                     # stores current player's disc symbol
    @combination_positions = []            # stores positions of a winning combination
  end

  # Starts the game: prints intro and runs the main loop
  def play_game
    puts game_intro
    run_game
  end

  # Introductory text displayed when the game starts
  def game_intro
    <<~TEXT
      🎯 Welcome to Connect Four!

      Two players take turns dropping their discs into a 7-column, 6-row grid.
      The first to connect four discs in a row — vertically, horizontally, or diagonally — wins!

      Let the game begin!
    TEXT
  end

  # Main game loop — displays the board, processes player moves,
  # and checks for a winning move after each turn
  def run_game
    loop do
      @board.display_board
      process_move

      break if game_over?
    end
  end

  # Checks if the last move resulted in a win.
  # Parameters: game board, last move's row and column, and the current player's disc.
  def game_over?
    return false unless combination_found?

    declare_win
    true
  end

  def combination_found?
    game_board = @board.board
    row = @last_position[-1][0]
    column = @last_position[-1][1]
    winning_move?(game_board, row, column, @player_disc)
  end

  # Gets input from player, determines the correct disc, and updates the board
  def process_move
    player_input = @player.validate_player_input
    @player_disc = @player.player_move
    @last_position << @board.update_board(player_input, @player_disc)
  end

  # Helper method used by winning_move? to count same-disc occurrences in one direction
  # Uses deltas to move along a direction (row/col), and stops if out of bounds or different disc
  def count_combination(board, row, col, delta_row, delta_col, player_disc) # rubocop:disable Metrics/ParameterLists,Metrics/MethodLength
    count = 0
    current_row = row + delta_row
    current_col = col + delta_col

    while in_bounds?(board, current_row, current_col) &&
          board[current_row][current_col] == player_disc
      count += 1
      yield(current_row, current_col) if block_given? # captures matching positions if block is provided
      current_row += delta_row
      current_col += delta_col
    end

    count
  end

  # Checks if the given row and column are within the board boundaries
  def in_bounds?(board, row, col)
    row.between?(0, board.length - 1) &&
      col.between?(0, board[0].length - 1)
  end

  # Determines if the current move results in a win
  # Scans in all directions and their opposites to count matching discs
  def winning_move?(board, row, col, player_disc) # rubocop:disable Metrics/MethodLength
    positions = [] # to store matching disc positions
    @combination_positions.clear

    # Check each direction (and its opposite), summing matches in both
    # If the total (including the current disc) is 4 or more, a win is declared
    found = @directions.any? do |delta_row, delta_col|
      total_count = 1 +
                    count_combination(board, row, col, delta_row, delta_col, player_disc) do |row, col|
                      positions << [row, col]
                    end +
                    count_combination(board, row, col, -delta_row, -delta_col, player_disc) do |row, col|
                      positions << [row, col]
                    end

      total_count >= 4
    end

    # If win is found, store the winning combination for highlighting
    @combination_positions.concat([[row, col]] + positions) if found
    found
  end

  # Displays win message, highlights winning discs, and reprints the board
  def declare_win
    puts 'combination found, you win!'
    highlight
    @board.display_board
  end

  # Visually highlights the winning combination on the board
  def highlight
    @combination_positions.each do |row, col|
      @board.board[row][col] = "|\u263B |" # smiley face used as highlight
    end
  end
end
