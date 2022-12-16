
class Shopping_cart
  attr_accessor :name, :tax_status, :unit_price, :regular_price, :item_qty, :item, :id, :quantity, :cart, :remove_item
  

  def initialize
    @@cart = []
  end

  def self.add_to_cart(item, item_qty, unit_price)

    elements = {
      name: item.name,
      tax_status: item.tax_status,
      unit_price: unit_price,
      regular_price: item.regular_price,
      quantity: item_qty
    }

    @@cart << elements
  end

  def self.remove_item

    if @@cart.empty?
      puts 'Your cart is empty'
      return
    end

    puts 'Select an option:'
    puts '1. Remove item from cart'
    puts '2. Remove all items from cart'
    puts '3. Go back to main menu'
    response = gets.chomp
    case response.to_i
    when 1
      puts 'Select an item'
      @@cart.each_with_index do |item, index|
        puts "#{index + 1}. #{item[:name]}"
      end
      index = gets.chomp.to_i
      @@cart.delete_at(index - 1)
      puts 'Item removed from cart'
      
    when 2
      @@cart = []
      puts 'All items removed from cart'
      
    when 3
      return
    else
      puts 'Invalid option'
    end
  end

  def self.show

    if @@cart.empty?
      puts 'Your cart is empty'
      return
    end

    puts "Your cart:"
    puts "Item #{' ' * 10} Quantity #{' ' * 10} Unit price #{' ' * 10} Total price"
    @@cart.each do |item|
      puts "#{item[:name]} #{' ' * 10} #{item[:quantity]} #{' ' * 20} $#{format('%.2f', item[:unit_price])} #{' ' * 15} $#{format('%.2f', item[:quantity] * item[:unit_price])}"
    end
    puts "TOTAL NUMBER OF ITEMS: #{format('%.2f', total_items)}"
    puts "SUB-TOTAL: $#{format('%.2f', sub_total)}"
    puts "TAX (6.5%): $#{format('%.2f', tax)}"
    puts "TOTAL: $#{format('%.2f', total)}"
  end

  def self.total_items
    total_items = 0
    @@cart.map {|item| item[:quantity].to_i}.sum
  end

  def self.sub_total
    sub_total = 0
    @@cart.each do |item|
      sub_total += (item[:quantity].to_f * item[:unit_price].to_f)
    end
    sub_total
  end

  def self.tax
    tax = 0
    @@cart.each do |item|
      tax += (item[:quantity].to_f * item[:unit_price].to_f) * 0.065 if item[:tax_status] == 'Taxable'
    end
    tax
  end

  def self.total
    sub_total + tax
  end

end