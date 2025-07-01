# this file defines the GmeBoard class which hold the board logic
class GameBoard
  def initialize(board = nil)
    @board = board
    @disc = ["|\u2648|", "|\u264C|"]
    @visited_cells = []
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
    # @board[6][input - 1] = @disc[0]
    # 1. when the lowest row cell is empty and input is the same
    # as the cell column, occupy the cell with the disc and add
    # the occupied cell into the visited cell array
    # steps:
    # - 1: compare @disc[0] to @board[counter][input]
    # - 2: if true, decrement counter (counter -= 1) to move 1 level up
    # - 3:

    # counter = 6

    # loop do
    #   break if counter.negative?

    #   if @board[counter][input] == @disc[player_disc] ||
    #      @visited_cells.include?("#{counter}#{input}")
    #     counter -= 1
    #   elsif @board[counter][input] == '|  |'
    #     @visited_cells.push("#{counter}#{input}")
    #     @board[counter][input] = @disc[player_disc]
    #     break
    #   end
    # end
    row = 6
    column -= 1
    empty = '|  |'

    loop do
      break if row.negative?

      if @board[row][column] == empty
        @board[row][column] = @disc[player_disc]
        break
      else
        row -= 1
      end
    end

    # 2. but if it is already occupied move to the 1 level up row and
    # see if it the cell is vacant. keep looking until a vacant cell
    # is found or there are no rows left to look for.

    # 3. decrement the row_placement_counter each loop
  end
end
