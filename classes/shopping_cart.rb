require_relative 'inventory'
require 'date'

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

  def self.receipt(transaction_number, inventory, member)
    if @@cart.empty?
      puts 'Your cart is empty'
      return
    end
    @date = Date.today
    puts "TOTAL: $#{format('%.2f',total)}"
    puts "CASH: $"
    cash = gets.chomp.to_f
    if cash < total
      puts "Not enough cash"
      receipt
    end
    puts "CHANGE: $#{format('%.2f', cash - total)}"
    recipe = File.new("transaction_#{format('%06d', transaction_number)}_#{@date.strftime('%d%m%y')}.txt", 'w')
    recipe.puts @date.strftime('%B %d, %Y')
    recipe.puts "TRANSACTION: #{format('%06d', transaction_number)}"
    recipe.puts "ITEM #{' ' * 10} QUANTITY #{' ' * 10} UNIT PRICE #{' ' * 10} TOTAL"
    @@cart.each do |item|
      recipe.puts "#{item[:name]} #{' ' * 10} #{item[:quantity]} #{' ' * 20} $#{format('%.2f', item[:unit_price])} #{' ' * 15} $#{format('%.2f', item[:quantity] * item[:unit_price])}"
    end
    recipe.puts "#{'*' * 50}"
    recipe.puts "TOTAL NUMBER OF ITEMS: #{total_items}"
    recipe.puts "SUB-TOTAL: $#{format('%.2f',sub_total)}"
    recipe.puts "TAX (6.5%): $#{format('%.2f', tax)}"
    recipe.puts "TOTAL: $#{format('%.2f',total)}"
    recipe.puts "CASH: $#{format('%.2f',cash)}"
    recipe.puts "CHANGE: $#{format('%.2f', cash - total)}"
    recipe.puts "#{'*' * 50}"
    recipe.puts "YOU SAVED $#{format('%.2f', discount_amount)}!" if member == 'y'
    
    
    recipe.close
    
    Inventory.update(@@cart, inventory)

    @@cart = []
  end

  def self.discount_amount 
    discount = 0
    @@cart.each do |item|
      discount += (item[:regular_price] - item[:unit_price]) * item[:quantity]
    end
    discount
  end


end