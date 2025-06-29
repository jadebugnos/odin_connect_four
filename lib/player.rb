class Player
  def validate_player_input
    loop do
      puts 'Select a column by typing 1-6: '
      input = Integer(gets.chomp)

      return input if input.between?(1, 6)

      puts 'input out of range'
    rescue ArgumentError
      puts "That's not a number. Try again."
    end
  end
end
