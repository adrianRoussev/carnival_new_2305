class Visitor
  attr_reader :name, :height, :preferences, :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = parse_spending_money(spending_money)
    @preferences = []
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(threshold)
    height >= threshold
  end


  def parse_spending_money(money_string)
    money_string.delete('$').to_i
  end

  def reduce_spending_money(amount)
    @spending_money -= amount
  end
end
