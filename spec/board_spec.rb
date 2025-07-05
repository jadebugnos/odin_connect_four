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

  describe '#update_board' do
    subject(:game_board) { described_class.new }

    context 'when the player input is 7' do
      before do
        sample_array = [
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |']
        ]
        game_board.instance_variable_set(:@board, sample_array)
      end
      it 'will edit the board based on player input' do
        red_disc = "|\u2648|"
        player_input = 7

        expect do
          game_board.update_board(player_input, red_disc)
        end.to change { game_board.instance_variable_get(:@board)[5][6] }
          .from('|  |').to(red_disc)
      end
    end

    context 'when the lower row is occupied' do
      before do
        sample_array = [
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', '|  |'],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', "|\u2648|"],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', "|\u2648|"],
          ['|  |', '|  |', '|  |', '|  |', '|  |', '|  |', "|\u2648|"]
        ]
        game_board.instance_variable_set(:@board, sample_array)
      end

      it 'will place the disc in the next available row above' do
        player_input = 7
        disc = "|\u2648|"

        expect do
          game_board.update_board(player_input, disc)
        end.to change { game_board.instance_variable_get(:@board)[2][6] }
          .from('|  |').to(disc)
      end
    end
  end
end
