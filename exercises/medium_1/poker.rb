require 'pry'

# Include Card and Deck classes from the last two exercises.

class PokerHand
  attr_reader :my_cards

  def initialize(deck)
    @deck = deck
    @my_cards = []
    5.times {|_| my_cards << deck.draw }
  end

  def print
    puts @my_cards
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    flush? && straight? && my_cards.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    2.times do |index|
      return true if my_cards.count(my_cards[index]) == 4
    end
    false
  end

  def full_house?
    pairs = Hash.new(0)
    5.times do |index|
      pairs[my_cards[index].rank] += 1 if my_cards.count(my_cards[index]) == 2
      pairs[my_cards[index].rank] += 1 if my_cards.count(my_cards[index]) == 3
    end
    pairs.size == 2 && pairs.values.max == 3
  end

  def flush?
    flush_suit = my_cards.first.suit
    my_cards.all? {|card| card.suit == flush_suit }
  end

  def straight?
    numbers = []
    my_cards.each do |card|
      numbers << Card::CARD_RANKINGS[card.rank.to_s]
    end
    numbers.uniq!
    numbers.sort!
    numbers.size == 5 && numbers.last - 4 == numbers.first
  end

  def three_of_a_kind?
    3.times do |index|
      return true if my_cards.count(my_cards[index]) == 3
    end
    false
  end

  def two_pair?
    pairs = Hash.new(0)
    5.times do |index|
      pairs[my_cards[index].rank] += 1 if my_cards.count(my_cards[index]) == 2
    end
    pairs.size == 2
  end

  def pair?
    4.times do |index|
      return true if my_cards.count(my_cards[index]) == 2
    end
    false
  end
end

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

hand = PokerHand.new(Deck.new)
hand.print
# 5 of Clubs
# 7 of Diamonds
# Ace of Hearts
# 7 of Clubs
# 5 of Spades

puts hand.evaluate
# Two pair

# # Danger danger danger: monkey
# # patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# # Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
