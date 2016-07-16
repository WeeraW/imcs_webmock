require 'rails_helper'

RSpec.describe Inventory::ItemLotStockIn, type: :model do
  describe '#quantity' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(100_000_000) }
  end

  describe '#price_per_count' do
    it { should validate_numericality_of(:price_per_count).is_greater_than_or_equal_to(0.0000).is_less_than_or_equal_to(100_000_000.0000) }
  end

  describe 'Associations' do
    describe '#inventory_item_lot' do
      it { should belong_to(:inventory_item_lot).class_name('Inventory::ItemLot').with_foreign_key(:inventory_item_lot_id) }
    end
  end

  describe 'Scope' do
    it 'should equal to 10' do
      stock_in_record_has_price = create_list :inventory_item_lot_stock_in, 10, price_per_count: 10
      stock_in_record_not_has_price = create_list :inventory_item_lot_stock_in, 10, price_per_count: nil
      expect(Inventory::ItemLotStockIn.specified_price_per_count.count).to eq(10)
    end
  end
end
