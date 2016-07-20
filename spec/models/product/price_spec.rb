require 'rails_helper'

RSpec.describe Product::Price, type: :model do
  describe '#price_th' do
    it { should validate_presence_of(:price_th) }
    it { should validate_numericality_of(:price_th).is_greater_than_or_equal_to(0.000).is_less_than_or_equal_to(999_999.9999) }
  end

  describe '#product_product_id' do
    it { should validate_presence_of(:product_product_id) }
  end

  describe '#staff_id' do
    it { should validate_presence_of(:staff_id) }
  end

  describe 'Associations' do
    describe '#create_by' do
      it { should belong_to(:create_by).class_name('Staff').with_foreign_key(:staff_id) }
    end

    describe '#product' do
      it { should belong_to(:product).class_name('Product::Product').with_foreign_key(:product_product_id) }
    end
  end
end
