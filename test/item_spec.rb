require 'rspec'
require_relative '../classes/item'

describe Item do
  context 'when testing item' do
    before :each do
      istance1 = 'Milk: 5, $3.75, $3.50, Tax-Exempt'
      istance2 = 'Red Bull: 10, $10.00, $4.50, Taxable'
      istance3 = 'Flour: 1, $3.10, $2.75, Tax-Exempt'
      @item1 = Item.new(istance1)
      @item2 = Item.new(istance2)
      @item3 = Item.new(istance3)
    end

    it 'should return an istance of item1' do
      expect(@item1).to be_a(Item)
    end

    it 'should return the name of item1' do
      expect(@item1.name).to eq('Milk')
    end

    it 'should return the quantity of item1' do
      expect(@item1.quantity.to_i).to eq(5)
    end

    it 'should return the regular price of item1' do
      expect(@item1.regular_price).to eq(3.75)
    end

    it 'should return the member price of item1' do
      expect(@item1.member_price).to eq(3.50)
    end

    it 'should return the tax status of item1' do
      expect(@item1.tax_status).to eq('Tax-Exempt')
    end

    it 'should return an istance of item2' do
      expect(@item2).to be_a(Item)
    end

    it 'should return the name of item2' do
      expect(@item2.name).to eq('Red Bull')
    end

    it 'should return the quantity of item2' do
      expect(@item2.quantity.to_i).to eq(10)
    end

    it 'should return the regular price of item2' do
      expect(@item2.regular_price).to eq(10.00)
    end

    it 'should return the member price of item2' do
      expect(@item2.member_price).to eq(4.50)
    end

    it 'should return the tax status of item2' do
      expect(@item2.tax_status).to eq('Taxable')
    end

    it 'should return an istance of item3' do
      expect(@item3).to be_a(Item)
    end

    it 'should return the name of item3' do
      expect(@item3.name).to eq('Flour')
    end

    it 'should return the quantity of item3' do
      expect(@item3.quantity.to_i).to eq(1)
    end

    it 'should return the regular price of item3' do
      expect(@item3.regular_price).to eq(3.10)
    end

    it 'should return the member price of item3' do
      expect(@item3.member_price).to eq(2.75)
    end

    it 'should return the tax status of item3' do
      expect(@item3.tax_status).to eq('Tax-Exempt')
    end

  end
end