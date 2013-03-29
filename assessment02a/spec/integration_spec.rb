require 'rspec'

require 'ai_player'
require 'card'
require 'deck'
require 'pile'

# integration style test
describe "#play_turn" do
  let(:player) { AIPlayer.new(hand_cards) }
  let(:pile) { Pile.new(Card.new(:clubs, :three)) }
  let(:deck) { Deck.new(deck_cards) }

  context "with playable card in hand" do
    let(:hand_cards) { [Card.new(:clubs, :four)] }
    let(:deck_cards) { [] }

    it "plays a card out of its hand if possible" do
      player
        .should_receive(:play_card)
        .with(pile, hand_cards[0])

      player.play_turn(pile, deck)
    end
  end

  context "with no playable card in hand" do
    let(:hand_cards) { [] }

    let(:deck_cards) do
      [ Card.new(:hearts, :king),
        Card.new(:hearts, :seven),
        Card.new(:clubs, :four),
        Card.new(:hearts, :three) ]
    end

    it "draws until it takes in a playable card" do
      player
        .should_receive(:draw_from)
        .with(deck)
        .exactly(3)
        .times
        .and_call_original # calls the underlying `Player#draw_from`

      player.play_turn(pile, deck)
    end

    it "plays the first drawn playable card" do
      player
        .should_receive(:play_card)
        .with(pile, deck_cards[2])

      player.play_turn(pile, deck)
    end

    context "with no playable card in deck" do
      let(:deck_cards) do
        [ Card.new(:hearts, :king),
          Card.new(:hearts, :seven) ]
      end

      it "draws all cards into hand" do
        player
          .should_receive(:draw_from)
          .exactly(2)
          .times.and_call_original

        player.play_turn(pile, deck)
      end

      it "should not play a card" do
        player.should_not_receive(:play_card)

        player.play_turn(pile, deck)
      end
    end
  end
end
