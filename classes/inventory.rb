class Inventory
  attr_accessor :items, :quantity, :id, :update
  
  def initialize()
    @@items = []
  end

  def self.update(cart, inventory)
    @cart = cart
    
    @cart.each do |item|
      inventory.items.each do |inventory_item|
        inventory_item.quantity = (inventory_item.quantity.to_i - item[:quantity].to_i) if inventory_item.name == item[:name]
      end
    end
    File.open('./data/inventory.txt', 'w') do |file|
      inventory.items.each do |item|
        file.puts "#{item.name}: #{item.quantity}, $#{format('%.2f',
                                                             item.regular_price)}, $#{format('%.2f',
                                                                                            item.member_price)}, #{item.tax_status}"
      end
    end
  end

end