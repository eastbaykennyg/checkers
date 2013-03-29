# Represents a computer Crazy Eights player.
class AIPlayer
  attr_reader :cards

  # Creates a new player and deals him a hand of eight cards.
  def self.deal_player_in(deck)
    AIPlayer.new(deck.take(8))
  end

  def initialize(cards)
    @cards = cards
  end

  # Returns the suit the player has the most of; this is the suit to
  # switch to if player gains control via eight.
  def favorite_suit
    raise NotImplementedError
  end

  # Plays a card from hand to the pile, removing it from the hand.
  def play_card(pile, card)
    raise NotImplementedError
  end

  # Draw a card from the deck into player's hand.
  def draw_from(deck)
    raise NotImplementedError
  end

  # Choose any valid card from the player's hand to play; prefer non-eights
  # to eights (save those!). Return nil if no possible play.
  def choose_card(pile)
    raise NotImplementedError
  end

  # Try to choose a card; if AI has a valid play, play the card. Else, draw
  # from the deck and try again. If deck is empty, pass.
  def play_turn(pile, deck)
    loop do
      chosen_card = choose_card(pile)

      if not chosen_card.nil?
        play_card(pile, chosen_card)
        break
      elsif deck.count > 0
        draw_from(deck)
      else
        break
      end
    end
  end
end
