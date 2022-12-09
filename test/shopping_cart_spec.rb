require 'rspec'
require_relative '../classes/shopping_cart'
require_relative '../classes/item'

describe Shopping_cart do
  context 'When testing shopping cart' do
    before :each do
      istance1 = 'Milk: 5, $3.75, $3.50, Tax-Exempt'
      @item1 = Item.new(istance1)
      @cart = Shopping_cart.new(@item1, 10, 3.50)
    end

    it 'should return an istance of shopping cart' do
      expect(@cart).to be_a(Shopping_cart)
    end

    it 'should return the name of the item' do
      expect(@cart.name).to eq('Milk')
    end

    it 'should return the tax status of the item' do
      expect(@cart.tax_status).to eq('Tax-Exempt')
    end

    it 'should return the unit price of the item' do
      expect(@cart.unit_price).to eq(3.50)
    end

    it 'should return the regular price of the item' do
      expect(@cart.regular_price).to eq(3.75)
    end

    it 'should return the quantity of the item' do
      expect(@cart.quantity).to eq(10)
    end
  end
end

