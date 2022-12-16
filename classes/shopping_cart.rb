
class Shopping_cart
  attr_accessor :name, :tax_status, :unit_price, :regular_price, :item_qty, :item, :id, :quantity, :cart, :remove_item

  def initialize(item, item_qty, unit_price)
    @name = item.name
    @tax_status = item.tax_status
    @unit_price = unit_price
    @regular_price = item.regular_price
    @quantity = item_qty
  end

  def self.remove_item(cart)
    @cart = cart

    puts 'Select an option:'
    puts '1. Remove item from cart'
    puts '2. Remove all items from cart'
    puts '3. Go back to main menu'
    response = gets.chomp
    case response.to_i
    when 1
      puts 'Select an item'
      @cart.each_with_index do |item, index|
        puts "#{index + 1}. #{item.name}"
      end
      index = gets.chomp.to_i
      @cart.delete_at(index - 1)
      puts 'Item removed from cart'
      
    when 2
      @cart = []
      puts 'All items removed from cart'
      
    when 3
      return
    else
      puts 'Invalid option'
    end
  end

end