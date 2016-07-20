require 'rails_helper'

RSpec.describe Product::Product, type: :model do
  describe '#sku' do
    it { should validate_presence_of(:sku) }
    it do
      create :product_product, sku: 'TSET-SKU'
      should validate_uniqueness_of(:sku).case_insensitive
    end
  end

  describe '#name_th' do
    it { should validate_presence_of(:name_th) }
    it { should validate_length_of(:name_th).is_at_least(3).is_at_most(150) }
  end

  describe '#description_th' do
    it { should validate_length_of(:description_th).is_at_least(0).is_at_most(1000) }
  end

  describe '#name_en' do
    it { should validate_presence_of(:name_en) }
    it { should validate_length_of(:name_en).is_at_least(3).is_at_most(150) }
  end

  describe '#description_en' do
    it { should validate_length_of(:description_en).is_at_least(0).is_at_most(1000) }
  end

  describe '#saleable' do
    context 'when not supply :saleable' do
      it 'should equal false' do
        product_record = create :product_product
        expect(product_record.saleable).to be false
      end
    end
  end

  describe '#latest_price' do
    it 'should get only latest price' do
      price_records = build_list(:product_price, 4, price_th: 20.00)
      price_record = create(:product_price, price_th: 40.00)
      product_record = create :product_product, product_prices: price_records
      product_record.product_prices << price_record
      expect(product_record.latest_price).to eq(price_record.price_th)
    end

    context 'when have no any :product_prices' do
      it 'should :latest_price equal 0' do
        product_record = create :product_product
        expect(product_record.latest_price).to eq(0)
      end
    end
  end

  describe '::available_products' do
    it 'should get only :product_product that attribute :saleable equal TRUE' do
      product_records1 = create_list :product_product, 10
      product_records2 = create_list :product_product, 10, saleable: true
      expect(Product::Product.available_products.count).to eq(10)
      expect(Product::Product.available_products).to eq(product_records2)
    end
  end

  describe '#slug' do
    pending 'Nothing todo yet.'
  end

  describe '#staff_id' do
    it { should validate_presence_of(:staff_id) }
  end

  describe 'Associations' do
    describe '#last_editor' do
      it { should belong_to(:last_editor).class_name('Staff').with_foreign_key(:staff_id) }
    end

    describe '#contains' do
      it { should have_many(:contains).class_name('Product::Contain').dependent(:restrict_with_exception) }
    end

    describe '#product_prices' do
      it { should have_many(:product_prices).class_name('Product::Price').with_foreign_key(:product_product_id).dependent(:restrict_with_exception) }
    end
  end
end
