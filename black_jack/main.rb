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
    @person.first_round
    puts "Player has: #{@deck.show_all_card(@person.player_cards)}."
    puts "Dealer has: #{@deck.show_all_card(@person.dealer_cards)}."
  end

  def rest_round(who = 'player')
    @message.show_round
    if who == 'player'
      @person.player_select_a_card
      puts "Player has: #{@deck.show_all_card(@person.player_cards)}."
    else
      @person.dealer_select_a_card
      puts "Dealer has: #{@deck.show_all_card(@person.dealer_cards)}."
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
    loop do
      resp = @message.user_input_argv(
        'Player, Do you wannt get a card again? (Y/N)'
      )
      break if resp != 'Y'
      rest_round
      break if score_over?(score_of_player)
    end
    check_player_score
  end

  def each_dealer_round
    loop do
      break if score_over?(score_of_dealer) || score_of_dealer >= score_of_player
      rest_round 'dealer'
    end
    check_final_score
  end

  def check_player_score
    @message.player_is_lost? true if score_over? score_of_player
  end

  def check_final_score
    @message.player_is_lost? !(score_over?(score_of_dealer) || score_of_dealer < score_of_player)
  end
end

game = Game.new
game.check_player_stake

game.first_round
game_is_end = game.each_player_round
game.end_of_game if game_is_end

game.each_dealer_round
game.end_of_game
