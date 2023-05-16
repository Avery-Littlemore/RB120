require 'pry'

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


cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
# puts cards
# 2 of Hearts
# 10 of Diamonds
# Ace of Clubs

puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

=begin
2 of Hearts
10 of Diamonds
Ace of Clubs
true
true
true
true
true
true
true
true
true
true
=end