
class Item
  attr_accessor :name, :regular_price, :member_price, :tax_status, :quantity, :id
  def initialize(item_str)
    parse_item(item_str)
  end

  def parse_item(item_str)
    props = item_str.split(",").map(&:strip)
    @regular_price = props[1].gsub(/[^\d\.]/, '').to_f
    @member_price = props[2].gsub(/[^\d\.]/, '').to_f
    @tax_status = props[3]
    @name, @quantity = props[0].split(":").map(&:strip)
  end
end