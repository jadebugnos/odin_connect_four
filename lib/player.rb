class Player # rubocop:disable Style/Documentation
  # Initializes a Player with two disc symbols and an empty move history
  def initialize
    @disc = ["|\u2648|", "|\u264C|"] # Zodiac symbols used as player discs
    @last_move = [] # Tracks the last move to alternate discs
  end

  # Prompts the player to input a column number between 1 and 7
  # Repeats the prompt until a valid number is entered
  def validate_player_input
    loop do
      puts 'Select a column by typing 1-7: '
      input = Integer(gets.chomp) # Convert input to Integer

      return input if input.between?(1, 7) # Return if valid

      puts 'input out of range'
    rescue ArgumentError
      puts "That's not a number. Try again." # Handles non-integer input
    end
  end

  # Determines and returns which player's disc should be used
  # Alternates between the two discs based on the last move
  def player_move
    if @last_move[-1] == @disc[1] || @last_move.empty?
      @last_move << @disc[0] # Player 1's turn
      @disc[0]
    else
      @last_move << @disc[1] # Player 2's turn
      @disc[1]
    end
  end
end
