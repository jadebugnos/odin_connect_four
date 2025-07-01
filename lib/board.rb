# this file defines the GmeBoard class which hold the board logic
class GameBoard
  def initialize(board = nil)
    @board = board
  end

  def display_board
    create_blocks.each { |row| puts row.join }
  end

  def create_blocks
    if @board.nil?
      top_row = ['  1   2   3   4   5   6   7']
      @board = Array.new(42, '|  |').each_slice(7).to_a.unshift(top_row)
    else
      @board
    end
  end

  def update_board(column, player_disc) # rubocop:disable Metrics/MethodLength
    row = 6
    column -= 1
    empty = '|  |'

    loop do
      break if row.negative?

      if @board[row][column] == empty
        @board[row][column] = player_disc
        break
      else
        row -= 1
      end
    end
  end
end
