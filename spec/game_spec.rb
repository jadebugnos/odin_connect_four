require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

RSpec.describe Game do
  describe '#play_game' do
    let(:game_board) { double('game_board') }
    let(:player) { double('player') }
    subject(:game_start) { described_class.new(player, game_board) }

    before do
      allow(game_board).to receive(:display_board)
      allow(game_start).to receive(:puts)
      allow(game_start).to receive(:run_game)
    end

    context 'when run' do
      it 'it sends message to display game intro' do
        expect(game_start).to receive(:game_intro)
        game_start.play_game
      end

      it 'runs the game' do
        expect(game_start).to receive(:run_game)
        game_start.play_game
      end
    end
  end

  describe '#run_game' do
    let(:player) { double('player') }
    let(:board) { double('board') }
    subject(:game_running) { described_class.new(player, board) }

    before do
      allow(game_running).to receive(:game_over?).and_return(false, true)
      allow(board).to receive(:display_board)
      allow(game_running).to receive(:process_move)
    end

    context 'when the game is not over' do
      it 'call the methods' do
        expect(board).to receive(:display_board)
        expect(game_running).to receive(:process_move)
        game_running.run_game
      end
    end

    context 'when the game is over' do
      before do
        allow(game_running).to receive(:game_over?).and_return(true)
        allow(board).to receive(:display_board)
        allow(game_running).to receive(:process_move)
      end
      it 'will not call the methods' do
        expect(board).not_to receive(:display_board)
        expect(game_running).not_to receive(:process_move)
        game_running.run_game
      end
    end
  end
end
