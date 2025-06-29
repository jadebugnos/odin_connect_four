require_relative '../lib/board'

RSpec.describe GameBoard do
  describe '#display_board' do
    subject(:game_board) { described_class.new }
    before do
      sample_array = [
        ['  1   2   3   4   5   6   7'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |']
      ]
      allow(game_board).to receive(:create_blocks).and_return(sample_array)
      allow(game_board).to receive(:puts)
    end

    it 'will send message to output board in the terminal' do
      expect(game_board).to receive(:puts).at_least(6).times
      game_board.display_board
    end

    it 'should send message to create_blocks to modify the game board' do
      expect(game_board).to receive(:create_blocks)
      game_board.display_board
    end
  end

  describe '#create_blocks' do
    subject(:modified_board) { described_class.new }

    it 'returns a modified 2D array' do
      sample_array = [
        ['  1   2   3   4   5   6   7'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
        ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |']
      ]
      new_board = modified_board.create_blocks

      expect(new_board).to eql(sample_array)
    end
  end
end
