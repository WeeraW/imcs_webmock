require 'rails_helper'

RSpec.describe Product::Contain, type: :model do
  describe '#quantity' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(999) }
  end
  describe 'Associations' do
    describe '#inventory_item' do
      it { should belong_to(:inventory_item).class_name('Inventory::InventoryItem').with_foreign_key(:inventoy_inventory_item_id) }
    end
    describe '#product' do
      it { should belong_to(:product).class_name('Product::Product').with_foreign_key(:product_product_id) }
    end
  end
end
