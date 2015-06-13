require 'card.rb'

class Deck
  attr_reader :deck
  def self.start_deck
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck
  end

  def initialize(deck)
    @deck = deck
  end

  def shuffle
    old_deck = @deck.dup
    until @deck != old_deck #Ensure that deck is not shuffled to original arrangement
      @deck.shuffle!
    end
  end

  def take(n)
    taken_cards = []
    n.times do
      taken_cards << @deck.shift
    end
    taken_cards
  end

  def return_cards(card_arr)
    @deck += card_arr #@deck.concat(card_arr)
  end

end
