class BlackJackGame
  def initialize
    @@card_num_pool = (0..51).to_a
    @@player = []
    @@dealer = []
    @@own_ace = {"dealer" => 0, "player" => 0}
  end

  def get_score_player
    handle_ace_score(@@own_ace["player"], sum_score(@@player))
  end

  def get_score_dealer
    handle_ace_score(@@own_ace["dealer"], sum_score(@@dealer))
  end

  def handle_ace_score(own_ace, score)
    if (own_ace != 0)
      # candidate_score = [score, score + 10]
      if (score + 10 > 21 || score > score + 10)
        return score
      end
      return score + 10
    end
    return score
  end

  def select_a_card
    pick_num = @@card_num_pool.sample
    @@card_num_pool.delete(pick_num)
    return pick_num
  end

  # def show_all_card(pick_num_array)
  #   card_sets = []
  #   pick_num_array.each do |pick_num|
  #     card_sets.push(transfer_card_type(pick_num) + transfer_card_num(pick_num).to_s)
  #   end
  #   return card_sets.join(", ")
  # end

  def cal_ace_card(pick_card, person = "dealer")
    if (pick_card % 13 == 0)
      (person == "player") ? @@own_ace["player"] = pick_card : @@own_ace["dealer"] = pick_card
    end
  end

  # def transfer_card_type(pick_num)
  #   case pick_num
  #   when 0..12
  #     return "spade"
  #   when 13..25
  #     return "heart"
  #   when 26..38
  #     return "diamond"
  #   when 39..51
  #     return "club"
  #   else
  #     return "Error"
  #   end
  # end

  # def transfer_card_num(pick_num)
  #   num = pick_num % 13
  #   case num
  #   when 0
  #     return "A"
  #   when 10
  #     return "J"
  #   when 11
  #     return "Q"
  #   when 12
  #     return "K"
  #   else
  #     return num + 1
  #   end
  # end

  # def sum_score(card_set)
  #   score = 0
  #   ace_score = 0
  #   card_set.each do |card|
  #     score += transfer_score(card)
  #   end
  #   return score
  # end

  # def check_score_is_over(score)
  #   (score > 21) ? true : false
  # end

  # def transfer_score(pick_num)
  #   num = pick_num % 13
  #   case num
  #   when 0
  #     return 1
  #   when 10..12
  #     return 10
  #   else
  #     return num + 1
  #   end
  # end

  def each_round_player
    # 1. select a card
    @@player.push(select_a_card)
    # 2. check the score
    score = get_score_player
    puts "Player has: " + show_all_card(@@player) + ". Score: #{score}"
    check_score_is_over(score)
  end

  def each_round_dealer
    # 1. select a card
    @@dealer.push(select_a_card)
    # 2. check the score
    score = get_score_dealer
    puts "Dealer has: " + show_all_card(@@dealer) + ". Score: #{score}"
    check_score_is_over(score)
  end

  def first_round
    2.times {
      @@player.push(select_a_card)
      @@dealer.push(select_a_card)
    }
    puts "Player has: " + show_all_card(@@player)
    puts "Dealer has: " + show_all_card(@@dealer)
    # 2. check the score
    check_score_is_over(get_score_player)
    check_score_is_over(get_score_dealer)
  end

  def who_is_winner
    dealer_score = get_score_dealer
    player_score = get_score_player
    r = if (player_score > 21)
          "Dealer"
        elsif (dealer_score > 21)
          "Player"
        elsif (player_score >= dealer_score)
          "Player"
        else
          "Dealer"
        end
    puts "=============="
    puts "#{r} is winner!"
    puts "=============="
    return r
  end
end


# ================
# Main code Area
# ================

def input_argv
  gets.chomp
end

puts "Welcome to Black Jack Game. Ready? (Y/N)"
conti = gets.chomp
if conti == "Y"
  momeyobj = MoneyManage.new
  # enough_money = true
  # while (enough_money)
  puts "How much are you in? (You have $#{momeyobj.get_player_money} now)"
  input_stake = input_argv
  #   enough_money = momeyobj.check_money_pool(input_stake)
  # end
  puts "=========="
  puts "Round 1"
  puts "=========="
  game = BlackJackGame.new
  game.first_round
  round = 2
  until (game.get_score_player > 21 || conti == "N")
    puts "Player, Do you wannt get a card again? (Y/N)"
    conti = gets.chomp
    if conti == "N"
      break
    end
    puts "=========="
    puts "Player Round " + round.to_s
    puts "=========="
    game.each_round_player
    round += 1
  end
  round = 2
  until (game.get_score_dealer > 21 || game.get_score_dealer >= game.get_score_player)
    puts "=========="
    puts "Dealer Round " + round.to_s
    puts "=========="
    game.each_round_dealer
    round += 1
  end
  winner = game.who_is_winner
  momeyobj.cal_award(winner, input_stake.to_i)
end
puts "Goodbye! Have a nice day!"
