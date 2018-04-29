# Person
class Person
  attr_reader :player_money
  attr_reader :player_cards
  attr_reader :dealer_cards
  attr_reader :own_ace
  def initialize(deck)
    @player_cards = []
    @dealer_cards = []
    @pocker_card_pool = deck
    @player_money = 30_000
    @own_ace = { 'dealer' => 0, 'player' => 0 }
  end

  def renew_cards(deck)
    @pocker_card_pool = deck
    @player_cards = []
    @dealer_cards = []
    @own_ace = { 'dealer' => 0, 'player' => 0 }
  end

  def check_enough_money(stake)
    numeric_stake = stake.to_i
    raise 'Please enter an interger!' if numeric_stake.to_s != stake
    raise 'Sorry, you has no enough money!' if @player_money < numeric_stake
    true
  rescue StandardError => e
    puts e.message
    false
  end

  def select_a_card
    pick_card = @pocker_card_pool.sample
    @pocker_card_pool.delete(pick_card)
    pick_card
  end

  def ace_card?(pick_card)
    (pick_card % 13).zero?
  end

  def player_select_a_card
    selected_a_card = select_a_card
    @own_ace['player'] += 1 if ace_card?(selected_a_card)
    @player_cards.push(selected_a_card)
  end

  def dealer_select_a_card
    selected_a_card = select_a_card
    @own_ace['dealer'] += 1 if ace_card?(selected_a_card)    
    @dealer_cards.push(selected_a_card)
  end

  def first_round
    2.times do
      player_select_a_card
      dealer_select_a_card
    end
  end

  def cal_score(ace_cards, score)
    ace_cards != 0 && (score + 10 <= 21 || score < score + 10) ? score + 10 : score
  end

  def cal_player_money(stake, is_player_win)
    stake = stake.to_i
    @player_money += is_player_win ? stake : -stake
  end
end
