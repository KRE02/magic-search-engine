class PartnerCardSheet
  def initialize(elements)
    @pairs = elements.group_by{|c| [c.main_front, c.main_front.partner].to_set }.values
    raise unless @pairs.all?{|pair| pair.size == 2}
  end

  def random_card
    raise "Partner sheet can only return 2 cards at time"
  end

  def random_cards_without_duplicates(count)
    raise "Partner sheet can only return 2 cards at time" unless count == 2
    @pairs.sample.shuffle
  end

  def cards
    @pairs.flatten
  end

  def probabilities
    result = Hash.new(Rational(0,1))
    total = @pairs.size * 2
    @pairs.each do |a, b|
      result[a] += Rational(1, total)
      result[b] += Rational(1, total)
    end
    result
  end
end