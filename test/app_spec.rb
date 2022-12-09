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
      expect(@app.member.length).equal? 0
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
      istance1 = 'Milk: 5, $3.75, $3.50, Tax-Exempt'
      @item1 = Item.new(istance1)
      @cart = Shopping_cart.new(@item1, 10, 3.50)
      @app.shopping_cart << @cart
    end

    it 'should return the shopping cart with one item' do
      expect(@app.shopping_cart.length).to eq 1
    end

    it 'should return the shopping cart with no items' do
      p @item1.id
      allow(@app).to receive(:gets).and_return("1", "#{@item1.id.to_s}")
      @app.remove_item_from_cart
      expect(@app.shopping_cart.length).to eq 0 
    end

    # it 'should eliminate all items in shopping cart' do
    #   @app.remove_item_from_cart
    #   allow(@app).to receive(:gets).and_return('y', '1', @item1.id.to_s, '1', 'y', '1', @item1.id.to_s, '1', 'n')
    #   expect(@app.shopping_cart.length).equal? 0
    # end
  end
    
end