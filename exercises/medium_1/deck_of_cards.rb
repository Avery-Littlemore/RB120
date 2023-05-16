require 'pry'

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @shuffled_cards.empty?
    @shuffled_cards.pop
  end

  private

  def reset
    unshuffled_cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        unshuffled_cards << Card.new(rank, suit)
      end
    end
    @shuffled_cards = unshuffled_cards.shuffle
  end
end

class Card
  CARD_RANKINGS = {
    'Ace' => 14,
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'Jack' => 11,
    'Queen' => 12,
    'King' => 13
  }

  SUIT_RANKINGS = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
  MAX_RANK = 14

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def >(other)
    CARD_RANKINGS[self.rank.to_s] > CARD_RANKINGS[other.rank.to_s]
  end

  def <(other)
    CARD_RANKINGS[self.rank.to_s] < CARD_RANKINGS[other.rank.to_s]
  end

  def <=>(other)
    case
    when self > other then 1
    when self < other then -1
    when SUIT_RANKINGS.index(self.suit) > SUIT_RANKINGS.index(other.suit) then 1
    when SUIT_RANKINGS.index(self.suit) < SUIT_RANKINGS.index(other.suit) then -1
    end
  end

  def ==(other)
    self.rank == other.rank
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.