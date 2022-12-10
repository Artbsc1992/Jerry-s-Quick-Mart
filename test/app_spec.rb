require 'rspec'
require_relative '../classes/inventory'
require_relative '../classes/shopping_cart'
require_relative '../classes/item'
require_relative '../app'

describe App do
  context 'Test app initialization' do
    before :each do
      @app = App.new
    end

    it 'should return an instance of app' do
      expect(@app).to be_a(App)
    end

    it 'should loaded the inventory' do
      expect(@app.inventory.items.length).to be > 0
    end

    it 'should return an empty shopping cart' do
      expect(@app.shopping_cart.length).to eq 0
    end

    it 'should return empty member status' do
      expect(@app.member).to eq ''
    end

    it 'should return the number of transactions' do
      file = File.readlines('./data/transaction_number.txt')
      @transaction_number = file[0].to_i
      expect(@app.transaction_number).to eq @transaction_number
    end
  end

  context 'Test remove item from shopping cart and view shopping cart' do
    before :each do
      @app = App.new
      @app.member = 'y'
      istance1 = 'Milk: 5, $3.75, $3.50, Tax-Exempt'
      @item1 = Item.new(istance1)
      @cart = Shopping_cart.new(@item1, 10, 3.50)
      @app.shopping_cart << @cart
    end

    it 'should return the shopping cart with no items' do
      allow(@app).to receive(:gets).and_return("1", "1")
      @app.remove_item_from_cart
      expect(@app.shopping_cart.length).to eq 0 
    end

    it 'should eliminate all items in shopping cart' do
      allow(@app).to receive(:gets).and_return("2")
      @app.remove_item_from_cart
      expect(@app.shopping_cart.length).equal? 0
    end

  end

  context 'when testing mathematical operations' do
    before :each do
      @app = App.new
      @app.member = 'y'
      istance1 = 'Milk: 5, $3.75, $3.50, Tax-Exempt'
      @item1 = Item.new(istance1)
      @cart = Shopping_cart.new(@item1, 10, 3.50)
      @app.shopping_cart << @cart
    end

    it 'should return the total number of items' do
      expect(@app.total_items).to eq 10
    end

    it 'should return the subtotal' do
      expect(@app.sub_total).to eq 35.00
    end

    it 'should return the tax' do
      expect(@app.tax).to eq 0.00
    end

    it 'should return the total' do
      expect(@app.total).to eq 35.00
    end
  end

  context 'when testing the checkout and cancel transation' do
    before :each do
      @app = App.new
      @app.member = 'y'
      istance1 = 'Milk: 5, $3.75, $3.50, Tax-Exempt'
      @item1 = Item.new(istance1)
      @cart = Shopping_cart.new(@item1, 2, 3.50)
      @app.shopping_cart << @cart
    end

    it 'when select cancel transaction should return the shopping cart empty' do
      allow(@app).to receive(:gets).and_return("5")
      @app.cancel_transaction
      expect(@app.shopping_cart.length).to eq 0
    end
    
  end
    
end