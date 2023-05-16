require 'pry'
=begin
Twenty-One is a card game consisting of a dealer and a player,
where the participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays,
  then the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

Nouns: Participants (player, dealer), cards, deck, player, game, total
Verbs: Dealt, hit, stay, bust

Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- deal (should this be here, or in Deck?)
Participant
Deck
- deal (should this be here, or in Dealer?)
Card
Game
- start

=end

class Participant
  attr_accessor :hand
  attr_accessor :name

  def initialize
    @hand = []
  end

  def hit(deck)
    hand << deck.draw_card
  end

  def display_hand
    if hand.size == 2
      hand.join(' and ')
    else
      result = hand.dup
      result[-1] = "and #{hand.last}"
      result.join(', ')
    end
  end

  def convert(card)
    case card
    when 'Ace'
      1
    when 'Jack', 'Queen', 'King'
      10
    else
      card.to_i
    end
  end

  def total
    result = []
    hand.each do |card|
      value = card.split.first
      result << convert(value)
    end
    if result.sum < 12 && result.include?(1)
      result.sum + 10
    else
      result.sum
    end
  end
end

class Player < Participant
end

class Dealer < Participant
end

class Deck
  STACK = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King).freeze
  SUITS = %w(Clubs Diamonds Hearts Spades).freeze

  attr_reader :cards

  def initialize
    reset
  end

  def draw_card
    suit = cards.select { |_, v| v != [] }.keys.sample
    card = cards[suit].shuffle!.pop
    "#{card} of #{suit}"
  end

  def deal(player, dealer)
    player.hand << draw_card
    dealer.hand << draw_card
    player.hand << draw_card
    dealer.hand << draw_card
  end

  def reset
    @cards = {
      SUITS[0].dup => STACK.dup,
      SUITS[1].dup => STACK.dup,
      SUITS[2].dup => STACK.dup,
      SUITS[3].dup => STACK.dup
    }
  end
end

class Game
  attr_reader :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def deal_cards
    deck.deal(player, dealer)
  end

  def display_hand(participant, hidden_card: false)
    puts "----- #{participant.name}'s hand -----"
    if hidden_card == false
      participant.hand.each do |card|
        puts card
      end
      puts "=> Total: #{participant.total}"
    else
      puts "#{participant.hand.first}"
      puts "Unknown card (face down)"
      puts "=> Total: ???"
    end
    puts ""
  end

  def show_initial_cards
    display_hand(player)
    display_hand(dealer, hidden_card: true)
  end

  def player_turn
    puts "#{player.name}'s turn..."
    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = gets.chomp.downcase
      if answer == 'h'
        puts "Player hits!"
        player.hit(deck)
        display_hand(player)
        break if player.total > 21
      elsif answer == 's'
        break
      else
        puts "Sorry that is not a valid input (h or s)."
      end
    end
  end

  def dealer_turn
    return if player.total > 21
    display_hand(dealer)
    loop do
      break if dealer.total > 16 || dealer.total > player.total
      puts "#{dealer.name} hits!"
      dealer.hit(deck)
    end
  end

  def show_result
    if player.total > 21
      puts "#{player.name} busted - dealer wins!"
    elsif dealer.total > 21
      puts "#{dealer.name} busted - player wins!"
    elsif player.total > dealer.total
      puts "#{player.name} wins with a score of #{player.total} vs #{dealer.total}."
    elsif player.total == dealer.total
      puts "Tie goes to #{dealer.name}... the house always wins!"
    else
      puts "#{dealer.name} wins with a score of #{player.total} vs #{dealer.total}."
    end
  end

  def greet_and_set_names
    puts "Welcome to Twenty-One! What is your name?"
    player.name = gets.chomp
    dealer.name = ['R2D2', 'Hal', 'Chappie', 'Sonny'].sample
  end

  def start
    system 'clear'
    greet_and_set_names
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start
