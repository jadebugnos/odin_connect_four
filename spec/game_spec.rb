require_relative '../lib/game'

RSpec.describe Game do
  describe '#play_game' do
    let(:game_board) { double('game_board') }
    let(:player) { double('player') }
    subject(:game_start) { described_class.new(player, game_board) }

    before do
      allow(game_board).to receive(:display_board)
      allow(game_start).to receive(:puts)
    end

    context 'when run' do
      it 'it sends message to display game intro' do
        expect(game_start).to receive(:game_intro)
        game_start.play_game
      end

      it 'displays the game_board' do
        expect(game_board).to receive(:display_board)
        game_start.play_game
      end

      it 'runs the game' do
        expect(game_start).to receive(:run_game)
        game_start.play_game
      end
    end
  end

  describe '#run_game' do
    subject(:game_running) { described_class.new }

    context 'when the game is not over' do
      it 'asks if game is over every round' do
        expect(game_running).to receive(:game_over?)
      end
    end
  end
end
