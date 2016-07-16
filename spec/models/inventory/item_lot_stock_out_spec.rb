require 'rails_helper'

RSpec.describe Inventory::ItemLotStockOut, type: :model do
  describe '#quantity' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(100_000_000) }
  end

  describe 'Associations' do
    describe '#inventory_item_lot' do
      it { should belong_to(:inventory_item_lot).class_name('Inventory::ItemLot').with_foreign_key(:inventory_item_lot_id) }
    end
  end
end
