# this file defines the GmeBoard class which hold the board logic
class GameBoard
  def initialize
    @board = (1..42).to_a.each_slice(7).to_a
  end

  def display_board
    create_blocks.each { |row| puts row.join }
  end

  def create_blocks
    @board.flat_map do |row|
      row.map do |num|
        num.between?(1, 9) ? "|0#{num}|" : "|#{num}|"
      end
    end.each_slice(7).to_a
  end
end
