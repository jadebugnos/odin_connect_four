# this file defines the GmeBoard class which hold the board logic
class GameBoard
  def initialize
    @board = (1..42).to_a.each_slice(7).to_a
  end

  def display_board
    create_blocks.each { |row| puts row.join }
  end

  def create_blocks
    @board
  end
end
