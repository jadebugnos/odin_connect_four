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
      allow(board).to receive(:display_board)
      allow(game_running).to receive(:process_move)
      allow(game_running).to receive(:game_over?).and_return(false, true)
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
        allow(board).to receive(:display_board)
        allow(game_running).to receive(:process_move)
        allow(game_running).to receive(:game_over?).and_return(true)
      end
      it 'not call the methods' do
        expect(board).not_to receive(:display_board)
        expect(game_running).not_to receive(:process_move)
      end
    end
  end

  describe '#game_over?' do
    let(:player) { double('player') }
    let(:board) { double('board') }
    subject(:game_end) { described_class.new(player, board) }

    context 'when the game is over' do
      before do
        allow(game_end).to receive(:combination_found?).and_return(true)
      end

      it 'declares the win and returns true' do
        expect(game_end).to receive(:declare_win)
        expect(game_end.game_over?).to eq(true)
      end
    end

    context 'when the game is not over' do
      before do
        allow(game_end).to receive(:combination_found?).and_return(false)
      end

      it 'does not call declare_win and returns false' do
        expect(game_end).not_to receive(:declare_win)
        expect(game_end.game_over?).to eq(false)
      end
    end
  end

  describe 'combination_found?' do
    let(:player) { double('player') }
    let(:board) { double('board') }
    subject(:finding_combination) { described_class.new(player, board) }

    before do
      allow(board).to receive(:board)
      finding_combination.instance_variable_set(:@last_position, [[5, 2], [4, 2], [5, 3]])
      finding_combination.instance_variable_set(:@player_disc, [[], []])
    end

    it 'returns true if if a winning move has been found' do
      allow(finding_combination).to receive(:winning_move?).and_return(true)
      search = finding_combination.combination_found?

      expect(search).to eq(true)
    end

    it 'returns false if a winning move has not been found' do
      allow(finding_combination).to receive(:winning_move?).and_return(false)
      search = finding_combination.combination_found?

      expect(search).to eq(false)
    end
  end
end
