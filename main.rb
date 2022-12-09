require_relative 'app'

def main
  app = App.new

  response = nil

  puts "Welcome to the Jerry's store!"
  puts "Is the customer a member? (y/n)"
  app.member_status
  
  while response != 'q'
    puts 'What would you like to do?'
      puts '1. Shop'
      puts '2. remove from cart'
      puts '3. View cart'
      puts '4. Checkout'
      puts '5. cancel transaction'
      puts 'q. Quit'
      response = gets.chomp

      case response
      when '1'
        app.shop
      when '2'
        app.remove_item_from_cart
      when '3'
        app.view_cart
      when '4'
        app.checkout
      when '5'
        app.cancel_transaction
      when 'q'
        break
      else
        puts 'Invalid response' 
      end

  end

  puts "Thank you for shopping at Jerry's store!"
end

main