require_relative 'classes/inventory'
require_relative 'classes/shopping_cart'
require_relative 'classes/item'
require 'date'

class App
  attr_accessor :inventory, :shopping_cart, :member, :transaction_number

  def initialize
    @inventory = Inventory.new
    @shopping_cart = []
    @member = ''
    self.upload_inventory
    @transaction_number = transaction_number
  end


  def upload_inventory
    # puts 'Write your inventory txt file name'
    file_name = './data/inventory.txt'
    file = File.open(file_name)
    @inventory.items = file.readlines.map(&:chomp).map do |item|
      Item.new(item)
    end
  end

  def transaction_number
   file = File.readlines('./data/transaction_number.txt')
   file[0].to_i
  end

  def member_status
    @member = gets.chomp
  end

  def shop
    #If they are not a member, we show them the regular price
    puts "Select an item"

    @inventory.items.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name}: stock: #{item.quantity}, $#{@member == 'y' ? item.member_price : item.regular_price}" if item.quantity.to_i > 0 
    end

    index = gets.chomp.to_i

    if @inventory.items[index - 1].nil?
      puts "Invalid item"
      return
    end

    puts "How many items would you like to pick?"
    item_qty = gets.chomp.to_i

    item = @inventory.items[index - 1]
    if !item.nil?
      if item.quantity.to_i < item_qty
        puts "Not enough items in stock"
        item_qty = ''
        return
      end
    else
      puts "Invalid item"
    end

    unit_price = @member == 'y' ? item.member_price : item.regular_price
    @shopping_cart << Shopping_cart.new(item, item_qty, unit_price)
    puts "Item added to cart"
    puts "Would you like to add another item? (y/n)"
    response = gets.chomp
    if response == 'y'
      shop
    end
    
  end

  def remove_item_from_cart 

    if @shopping_cart.empty?
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
      @shopping_cart.each_with_index do |item, index|
        puts "#{index + 1}. #{item.name}"
      end
      index = gets.chomp.to_i
      @shopping_cart.delete_at(index - 1)
      puts 'Item removed from cart'
      
    when 2
      @shopping_cart = []
      puts 'All items removed from cart'
      
    when 3
      return
    else
      puts 'Invalid option'
    end

  end

  def view_cart
    if @shopping_cart.empty?
      puts 'Your cart is empty'
      return
    end
    puts "Your cart:"
    puts "Item #{' ' * 10} Quantity #{' ' * 10} Unit price #{' ' * 10} Total price"
    @shopping_cart.each do |item|
      puts "#{item.name} #{' ' * 10} #{item.quantity} #{' ' * 20} $#{format('%.2f', item.unit_price)} #{' ' * 15} $#{format('%.2f', item.quantity * item.unit_price)}"
    end
    puts "TOTAL NUMBER OF ITEMS: #{format('%.2f', total_items)}"
    puts "SUB-TOTAL: $#{format('%.2f', sub_total)}"
    puts "TAX (6.5%): $#{format('%.2f', tax)}"
    puts "TOTAL: $#{format('%.2f', total)}"
  end

  def total_items
    total_items = 0
    @shopping_cart.map {|item| item.quantity.to_i}.sum
  end

  def sub_total
    sub_total = 0
    @shopping_cart.each do |item|
      sub_total += (item.quantity.to_f * item.unit_price.to_f)
    end
    sub_total
  end

  def tax
    tax = 0
    @shopping_cart.each do |item|
      tax += (item.quantity.to_f * item.unit_price.to_f) * 0.065 if item.tax_status == 'Taxable'
    end
    tax
  end

  def total
    sub_total + tax
  end

  def checkout
    if @shopping_cart.empty?
      puts 'Your cart is empty'
      return
    end
    @date = Date.today
    puts "TOTAL: $#{format('%.2f',total)}"
    puts "CASH: $"
    cash = gets.chomp.to_f
    if cash < total
      puts "Not enough cash"
      checkout
    end
    puts "CHANGE: $#{format('%.2f', cash - total)}"
    recipe = File.new("transaction_#{format('%06d', @transaction_number)}_#{@date.strftime('%d%m%y')}.txt", 'w')
    recipe.puts @date.strftime('%B %d, %Y')
    recipe.puts "TRANSACTION: #{format('%06d', @transaction_number)}"
    recipe.puts "ITEM #{' ' * 10} QUANTITY #{' ' * 10} UNIT PRICE #{' ' * 10} TOTAL"
    @shopping_cart.each do |item|
      recipe.puts "#{item.name} #{' ' * 10} #{item.quantity} #{' ' * 20} $#{format('%.2f', item.unit_price)} #{' ' * 15} $#{format('%.2f', item.quantity * item.unit_price)}"
    end
    recipe.puts "#{'*' * 50}"
    recipe.puts "TOTAL NUMBER OF ITEMS: #{total_items}"
    recipe.puts "SUB-TOTAL: $#{format('%.2f',sub_total)}"
    recipe.puts "TAX (6.5%): $#{format('%.2f', tax)}"
    recipe.puts "TOTAL: $#{format('%.2f',total)}"
    recipe.puts "CASH: $#{format('%.2f',cash)}"
    recipe.puts "CHANGE: $#{format('%.2f', cash - total)}"
    recipe.puts "#{'*' * 50}"
    recipe.puts "YOU SAVED $#{format('%.2f', discount_amount)}!" if @member == 'y'
    update_inventory
    @shopping_cart = []
    update_transaction_number
    recipe.close

  end

  def discount_amount 
    discount = 0
    @shopping_cart.each do |item|
      discount += (item.regular_price - item.unit_price) * item.quantity
    end
    discount
  end

  def update_inventory
    @shopping_cart.each do |item|
      @inventory.items.each do |inventory_item|
        inventory_item.quantity = (inventory_item.quantity.to_i - item.quantity.to_i) if inventory_item.name == item.name
      end
    end
    File.open('./data/inventory.txt', 'w') do |file|
      @inventory.items.each do |item|
        file.puts "#{item.name}: #{item.quantity}, $#{format('%.2f',
                                                             item.regular_price)}, $#{format('%.2f',
                                                                                            item.member_price)}, #{item.tax_status}"
      end
    end
  end

  def update_transaction_number
    @transaction_number += 1
    File.open('./data/transaction_number.txt', 'w') do |file|
      file.puts @transaction_number
    end
  end

  def cancel_transaction

    if @shopping_cart.empty?
      puts 'Your cart is empty'
      return
    end

    @shopping_cart = []
    p 'Transaction cancelled'
  end


end