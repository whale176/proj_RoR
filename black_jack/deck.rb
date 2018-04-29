# Deck
class Deck
  attr_reader :pocker_card_pool

  def initialize
    @pocker_card_pool = (0..51).to_a
  end

  def transfer_card_type(pick_num)
    case pick_num
    when 0..12
      'spade'
    when 13..25
      'heart'
    when 26..38
      'diamond'
    when 39..51
      'club'
    end
  end

  # cards = ['spade', 'heart', 'diamond', 'club'].product(('A', '2'..'10', 'J', 'Q', 'K').to_a)
  def transfer_card_num(pick_num)
    num = pick_num % 13
    case num
    when 0
      'A'
    when 10
      'J'
    when 11
      'Q'
    when 12
      'K'
    else
      num + 1
    end
  end

  def show_a_card(pick_num)
    transfer_card_type(pick_num) + transfer_card_num(pick_num).to_s
  end

  def show_all_card(pick_num_array)
    card_sets = []
    pick_num_array.each do |pick_num|
      card_sets.push(show_a_card(pick_num))
    end
    card_sets.join(', ')
  end

  def transfer_score(pick_num)
    num = pick_num % 13
    case num
    when 0
      return 1
    when 10..12
      return 10
    else
      return num + 1
    end
  end

  def sum_score(card_set, ace_cards)
    score = 0
    card_set.each do |card|
      score += transfer_score(card)
    end
    ace_cards != 0 && (score + 10 <= 21) ? score + 10 : score
  end

  def hit_or_stand
    puts 'Player, Do you wannt get a card again? (Y/N)'
  end
end
