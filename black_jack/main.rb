require "./person"
require "./deck"
require "./message"

# Game
class Game
  PLAYER = 'player'.freeze
  DEALER = 'dealer'.freeze
  def initialize
    @game_round = 1
    @deck = Deck.new
    @message = Message.new
    @person = Person.new @deck.pocker_card_pool
  end

  def start_the_game
    puts '=========='
    puts "Game #{@game_round}"
    puts '=========='
    @game_round += 1
    @person.renew_cards @deck.renew_deck
    @message.renew_round
  end

  def start_or_continue_the_game
    response_ready = if @game_round == 1
      @message.user_input_argv(
        'Welcome to Black Jack Game. Ready? (y/N)')
    else
      @message.user_input_argv(
        "Game #{@game_round - 1} ended.\n" + 
        "==========\n" +
        'Would you continue next game?')
    end
    # end_of_game if response_ready != 'Y'
    response_ready
  end

  def end_of_game
    puts 'Goodbye! Have a nice day!'
    exit
  end

  def check_player_stake
    player_stake = 0
    loop do
      player_stake = @message.user_input_argv(
        "Please place your bets. (You have $#{@person.player_money} now)"
      )
      break if @person.check_enough_money(player_stake)
    end
    player_stake
  end

  def first_round
    @message.show_round
    @person.first_round
    puts "Player has: #{@deck.show_all_card(@person.player_cards)}."
    puts "Dealer has: #{@deck.show_all_card(@person.dealer_cards)}."
  end

  def rest_round(who = PLAYER)
    @message.show_round
    if who == PLAYER
      @person.player_select_a_card
      puts "Player has: #{@deck.show_all_card(@person.player_cards)}."
    else
      @person.dealer_select_a_card
      puts "Dealer has: #{@deck.show_all_card(@person.dealer_cards)}."
    end
  end

  def score_of_dealer
    @deck.sum_score(@person.dealer_cards, @person.own_ace[DEALER])
  end

  def score_of_player
    @deck.sum_score(@person.player_cards, @person.own_ace[PLAYER])
  end

  def score_over?(score)
    score > 21
  end

  def ask_player_hit_or_stand
    loop do
      resp = @message.user_input_argv(
        'Player, Do you wannt get a card again? (y/N)'
      )
      break if resp != 'Y'
      rest_round
      break if score_over?(score_of_player)
    end
    show_message_of_results PLAYER
  end

  def each_dealer_round
    loop do
      break if score_over?(score_of_dealer) || score_of_dealer >= score_of_player
      rest_round DEALER
    end
    show_message_of_results
  end

  def show_message_of_results(whose_round = '')
    if whose_round == PLAYER
      @message.player_is_lost? true if score_over? score_of_player
    else
      @message.player_is_lost? !(score_over?(score_of_dealer) || score_of_dealer < score_of_player)
    end
  end

  def cal_player_money(stake, is_player_win)
    @person.cal_player_money(stake, is_player_win)
  end
end

game = Game.new
loop do
  break if game.start_or_continue_the_game != 'Y'
  game.start_the_game
  stake = game.check_player_stake
  game.first_round
  is_player_lost = game.ask_player_hit_or_stand
  if is_player_lost
    game.cal_player_money(stake, false)
    next
  end
  is_player_lost = game.each_dealer_round
  game.cal_player_money(stake, is_player_lost)
end

game.end_of_game
