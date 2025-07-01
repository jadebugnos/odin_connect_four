class Player # rubocop:disable Style/Documentation
  def initialize
    @disc = ["|\u2648|", "|\u264C|"]
    @last_move = []
  end

  def validate_player_input
    loop do
      puts 'Select a column by typing 1-7: '
      input = Integer(gets.chomp)

      return input if input.between?(1, 6)

      puts 'input out of range'
    rescue ArgumentError
      puts "That's not a number. Try again."
    end
  end

  def player_move
    if @last_move[-1] == @disc[1] || @last_move.empty?
      @last_move << @disc[0]
      @disc[0]
    else
      @last_move << @disc[1]
      @disc[1]
    end
  end
end
