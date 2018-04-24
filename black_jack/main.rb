require "./person"
require "./deck"
require "./message"

# Game
class Game
  def initialize
    @deck = Deck.new
    @message = Message.new
    @person = Person.new @deck.pocker_card_pool
  end

  def welcome
    response_ready = @message.user_input_argv(
      'Welcome to Black Jack Game. Ready? (Y/N)'
    )
    end_of_game if response_ready != 'Y'
  end

  def end_of_game
    @message.end_of_game
  end

  def check_player_stake
    loop do
      player_stake = @message.user_input_argv(
        "Please place your bets. (You have $#{@person.player_money} now)"
      )
      break if @person.check_enough_money(player_stake)
    end
  end

  def first_round
    @message.show_round
    both_num_cards = @person.first_round
    both_num_cards.each do |who, num_cards|
      puts "#{who} has: #{@deck.show_all_card(num_cards)}."
    end
  end

  def score_of_dealer
    @deck.sum_score(@person.dealer_cards, @person.own_ace['dealer'])
  end

  def score_of_player
    @deck.sum_score(@person.player_cards, @person.own_ace['player'])
  end

  def score_over?(score)
    score > 21
  end

  def each_player_round
    # check player score is over 21 ?
    loop do
      resp = @message.user_input_argv(
        'Player, Do you wannt get a card again? (Y/N)'
      )
      break if resp != 'Y' || score_over?(score_of_player)
    end
  end

  def check_player_score
    show_result if score_over? score_of_player
  end

  
end

game = Game.new
game.welcome
game.check_player_stake

# Start first round
game.first_round
game.each_player_round

# Each round

game.end_of_game
