require 'rspec'
require_relative '../classes/inventory'
require_relative '../app'

describe Inventory do
  context 'when testing inventory' do
    it 'should return an array of items' do
      inventory = Inventory.new
      expect(inventory.items).to be_a(Array)
    end
  end
end