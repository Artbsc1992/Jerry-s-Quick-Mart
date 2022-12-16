require_relative 'classes/inventory'
require_relative 'classes/shopping_cart'
require_relative 'classes/item'
require 'date'

class App
  attr_accessor :inventory, :cart, :member, :transaction_number, :shopping_cart

  def initialize
    @inventory = Inventory.new
    @cart = Shopping_cart.new
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

    Shopping_cart.add_to_cart(item, item_qty, unit_price)

    puts "Item added to cart"
    puts "Would you like to add another item? (y/n)"
    response = gets.chomp
    if response == 'y'
      shop
    end
    
  end

  def remove_item_from_cart 

    Shopping_cart.remove_item

  end

  def view_cart
    
    Shopping_cart.show
  end

  def checkout
    if @cart.empty?
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
    @cart.each do |item|
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
    @cart = []
    update_transaction_number
    recipe.close

  end

  def discount_amount 
    discount = 0
    @cart.each do |item|
      discount += (item.regular_price - item.unit_price) * item.quantity
    end
    discount
  end

  def update_inventory
    @cart.each do |item|
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

    if @cart.empty?
      puts 'Your cart is empty'
      return
    end

    @cart = []
    p 'Transaction cancelled'
  end


end