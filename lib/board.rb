# this file defines the GameBoard class which holds the board logic
class GameBoard
  attr_accessor :board # allows external access to the board for reading/writing

  def initialize(board = nil)
    @board = board # allows passing in a custom board, defaults to nil
  end

  # Displays the board with column numbers at the top
  def display_board
    puts '  1   2   3   4   5   6   7' # column headers
    create_blocks.each { |row| puts row.join } # prints each row of the board
  end

  # Creates a new 6x7 board if one doesn't exist yet
  def create_blocks
    if @board.nil?
      @board = Array.new(42, '|  |').each_slice(7).to_a # 6 rows x 7 columns
    else
      @board # return existing board
    end
  end

  # Updates the board by dropping the player's disc into the selected column
  # Starts from the bottom row and finds the first empty slot
  def update_board(column, player_disc) # rubocop:disable Metrics/MethodLength
    row = 5               # start at the bottom row (0-indexed)
    column -= 1           # convert 1-7 input to 0-6 index
    empty = '|  |'        # representation of an empty cell

    loop do
      break if row.negative? # stop if all rows are filled in this column

      if @board[row][column] == empty
        @board[row][column] = player_disc # place the disc
        return [row, column]              # return the position for tracking
      else
        row -= 1 # move upward to check the next cell
      end
    end
  end
end
