require 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new( suit, value )
      end
    end
    
    cards
  end

  def initialize(cards = Deck.all_cards)
    @all_cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @all_cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    take = []
    if @all_cards.count < n
      raise "not enough cards"
    else
      n.times { take << @all_cards.shift }
    end
    
    take
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    cards_rtn = cards.dup
    cards_rtn.each { |card| @all_cards << card }
    @all_cards
  end
end
