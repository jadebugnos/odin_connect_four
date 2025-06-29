# this file defines the GmeBoard class which hold the board logic
class GameBoard
  def initialize
    @board = nil
  end

  def display_board
    create_blocks.each { |row| puts row.join }
  end

  def create_blocks
    if @board.nil?
      @board = Array.new(42, '|  |').each_slice(7).to_a.unshift(['  1   2   3   4   5   6   7'])
    else
      @board
    end
  end

  # Reminder: refactor the board logic to display the board properly
  # to only show cells with no numbers and only the top row has numbers
end
