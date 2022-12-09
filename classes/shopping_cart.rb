
class Shopping_cart
  attr_accessor :name, :tax_status, :unit_price, :regular_price, :item_qty, :item, :id, :quantity

  def initialize(item, item_qty, unit_price)
    @name = item.name
    @tax_status = item.tax_status
    @unit_price = unit_price
    @regular_price = item.regular_price
    @quantity = item_qty
  end

end