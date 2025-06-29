require_relative '../lib/player'

RSpec.describe Player do
  describe '#validate_player_input' do
    subject(:valid_input) { described_class.new }

    context 'when the player input is valid' do
      before do
        allow(valid_input).to receive(:gets).and_return(rand(1..6).to_s)
        allow(valid_input).to receive(:puts)
      end
      it 'returns a valid number' do
        player_input = valid_input.validate_player_input

        expect(player_input).to be_between(1, 6)
      end

      it "will ask for player's input in the terminal" do
        expect(valid_input).to receive(:gets).once
        valid_input.validate_player_input
      end
    end

    context 'when the player input is invalid' do
      it 'will handle non integer inputs' do
        allow(valid_input).to receive(:gets).and_return('q', '2')

        expect { valid_input.validate_player_input }.to output(/That's not a number. Try again/).to_stdout
      end

      it 'will handle multiple invalid inputs' do
        allow(valid_input).to receive(:gets).and_return('@', '$', 'dfj', '3')
        error_message = /That's not a number.*That's not a number/m

        expect { valid_input.validate_player_input }.to output(error_message).to_stdout
      end

      it 'will handle out of range numbers' do
        allow(valid_input).to receive(:gets).and_return('10', '4')
        error_message = /input out of range/m

        expect { valid_input.validate_player_input }.to output(error_message).to_stdout
      end
    end
  end
end
