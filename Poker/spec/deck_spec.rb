require 'deck.rb'

describe Deck do
  subject(:deck) { Deck.new ([
    Card.new(:clubs, :three),
    Card.new(:hearts, :five),
    Card.new(:diamonds, :seven),
    Card.new(:spades, :four)
    ])}

  describe "::start_deck" do
    it "returns an array of 52 cards" do
      expect(Deck.start_deck.count).to eq(52)
    end

    it "returns an array of 52 unique cards" do
      expect(Deck.start_deck.uniq.count).to eq(52)
    end
  end

  describe "#deck" do
    it "returns an array of the deck" do
      expect(deck.deck.count).to eq(4)
    end
  end

  describe "#shuffle" do
    subject(:unshuffled_deck) { Deck.new ([
      Card.new(:clubs, :three),
      Card.new(:hearts, :five),
      Card.new(:diamonds, :seven),
      Card.new(:spades, :four)
      ])}
    it "should return a differently ordered deck" do
      deck.shuffle
      expect(deck.deck).to_not eq(unshuffled_deck.deck)
    end
  end

  describe "#take" do
    it "takes 1 card from the top (front) of the deck" do
      cards = deck.take(1)
      expect(deck.deck.count).to eq(3)
      expect(cards[0].suit).to eq(:clubs)
      expect(cards[0].value).to eq(:three)
    end

    it "takes 3 cards from the top (front) of the deck" do
      cards = deck.take(3)
      expect(deck.deck.count).to eq(1)
      expect(cards[0].suit).to eq(:clubs)
      expect(cards[0].value).to eq(:three)

      expect(cards[1].suit).to eq(:hearts)
      expect(cards[1].value).to eq(:five)

      expect(cards[2].suit).to eq(:diamonds)
      expect(cards[2].value).to eq(:seven)
    end
  end

  describe "#return_cards" do
    return_deck = [Card.new(:hearts, :ten), Card.new(:clubs, :four)]

    it "returns cards to the back (bottom) of deck" do
      deck.return_cards(return_deck)
      expect(deck.deck.count).to eq(6)

      expect(deck.deck.last.suit).to eq(:clubs)
      expect(deck.deck.last.value).to eq(:four)

      expect(deck.deck.first.suit).to eq(:clubs)
      expect(deck.deck.first.value).to eq(:three)
    end
  end

end
