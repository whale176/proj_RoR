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

  def 

  # until (game.get_score_player > 21 || conti == "N")
  #   puts "Player, Do you wannt get a card again? (Y/N)"
  #   conti = gets.chomp
  #   if conti == "N"
  #     break
  #   end
  #   puts "=========="
  #   puts "Player Round " + round.to_s
  #   puts "=========="
  #   game.each_round_player
  #   round += 1
  # end
end
