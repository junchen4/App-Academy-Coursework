class Hand
  attr_reader :hand

  def initialize(hand, deck)
    @hand = hand
    @deck = deck
  end

  def receive(new_cards)
    @hand += new_cards
  end

  def discard(card_indices)
    discard_pile = []
    card_indices.each do |i|
      discard_pile << @hand[i]
    end

    @hand.delete_if {|card| discard_pile.include?(card) }

    receive(@deck.take(discard_pile.count)) #receives new cards
    @deck.return_cards(discard_pile) #puts those discarded cards back into deck
    discard_pile
  end

  def points
    points = 0
    suits_hash = Hash.new(0)
    value_hash = Hash.new(0)
    @hand.each do |card|
      suits_hash[card.suit] += 1
      value_hash[card.value] += 1
    end

    #refactor below into separate methods for each type of hand
    first_suit = @hand[0].suit
    if @hand.all? {|card| card.suit == first_suit}
      if @hand.all? {|card| card.value != :ace }
        card_values = []
        @hand.each { |card| card_values << card.poker_value }
        card_values.sort!
        if card_values.last - card_values.first == 4
          points = 8 #straight flush
        else
          points = 5 #flush
        end
      else
        if @hand.all? do |card|
          card.value == :ace || card.value == :deuce || card.value == :three ||
          card.value == :four || card.value == :five
          end
          points = 8 #straight flush
        elsif @hand.all? do |card|
          card.value == :ace || card.value == :king || card.value == :queen ||
          card.value == :jack || card.value == :ten
          end
          points = 8 #straight flush
        else
          points = 5 #flush
        end
      end
      #refactor above
    elsif value_hash.values.max == 4
      points = 7
    elsif value_hash.values.max == 3 && value_hash.values.include?(2)
      points = 6
    end
    points
  end
end
