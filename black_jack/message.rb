# Message
class Message
  def initialize
    @round = 1
  end

  def user_input_argv(hint_message = nil)
    puts hint_message if hint_message
    gets.chomp
  end

  def end_of_game
    puts 'Goodbye! Have a nice day!'
    exit
  end

  def show_round
    puts '=========='
    puts "Round #{@round}"
    puts '=========='
    @round += 1
  end

  def show_both_cards(card_set, who)
    puts "#{who} has: #{card_set}"
  end

  def player_is_lost?(result = true)
    string = result ? 'Loses' : 'Wins'
    puts "Game is over! Player #{string}!"
    result
  end
end
