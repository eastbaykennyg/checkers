# Represents the common "pile" of cards on which to play Crazy Eights.
class Pile
  attr_reader :top_card

  def initialize(top_card)
    @top_card = top_card
    @eight_suit = nil
  end
  
  # Returns the current value in play. This is the value of the top card.
  def current_value
    @top_card.value
  end

  # Returns the current suit in play; either the suit of the top card,
  # or the suit specified by the previous player if an eight was
  # played.
  def current_suit
    @eight_suit || @top_card.suit
  end

  # Returns true if a card is valid to play in this circumstance. Card should
  # either:
  #   (1) be the same suit as the current suit,
  #   (2) be the same rank as the previous card,
  #   (3) be an eight.
  def valid_play?(card)
    @top_card.value == card.value || current_suit == card.suit || card.value == :eight
  end

  # Plays a non-eight card on the top of the pile, objecting if it is
  # not valid.
  def play(card)
    raise "invalid play" unless valid_play?(card)
    raise "must declare suit when playing eight" if card.value == :eight
    @top_card = card
    
    @eight_suit = nil
  end

  # Plays an eight on top of the pile, setting the suit choice.
  def play_eight(card, suit_choice)
    raise "must play eight" unless card.value == :eight
      
    @top_card = card
    @eight_suit = suit_choice
  end

end
