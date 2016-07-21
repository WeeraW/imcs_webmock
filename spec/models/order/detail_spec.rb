require 'rails_helper'

RSpec.describe Order::Detail, type: :model do
  describe '#quantity' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(999) }
  end

  describe '#price_per_count' do
    it { should validate_presence_of(:price_per_count) }
    it { should validate_numericality_of(:price_per_count).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(999_999_999.9999) }
  end

  describe 'Associations' do
    describe '#order' do
      it { should validate_presence_of(:order_order_id) }
      it { should belong_to(:order).class_name('Order::Order').with_foreign_key(:order_order_id) }
    end

    describe '#product' do
      it { should validate_presence_of(:product_product_id) }
      it { should belong_to(:product).class_name('Product::Product').with_foreign_key(:product_product_id) }
    end
  end
end
