require 'rails_helper'

RSpec.describe Inventory::ItemLot, type: :model do
  describe '#lot_number' do
    it { should validate_presence_of(:lot_number) }
  end

  describe '#mfg_date' do
    it { should validate_presence_of(:mfg_date) }
    it 'should validate lesser than :exp_date' do
      lot_record = build :inventory_item_lot, mfg_date: Date.today, exp_date: 1.day.ago
      expect { lot_record.save! }.to raise_error(ActiveRecord::RecordInvalid, /Mfg date must lesser than expiring date/i)
    end
  end

  describe '#exp_date' do
    it { should validate_presence_of(:exp_date) }
    it 'should validate not lesser than :mfg_date' do
      lot_record = build :inventory_item_lot, mfg_date: Date.today, exp_date: 1.day.ago
      expect { lot_record.save! }.to raise_error(ActiveRecord::RecordInvalid, /Exp date must greater than manufactoring date/i)
    end
  end

  describe '#available' do
    context 'when not have any :instock_items and :outstock_items' do
      before(:each) do
        @lot_record = create :inventory_item_lot
      end

      it 'should not have any :instock_items' do
        expect(@lot_record.instock_items.count).to eq(0)
      end

      it 'should not have any :outstock_items' do
        expect(@lot_record.outstock_items.count).to eq(0)
      end

      it 'should equal 0' do
        expect(@lot_record.available).to eq(0)
      end
    end

    context 'when have :instock_items and :outstock_items' do
      before(:each) do
        @lot_record = create :inventory_item_lot,
                             instock_items: create_list(:inventory_item_lot_stock_in, 20, quantity: 10),
                             outstock_items: create_list(:inventory_item_lot_stock_out, 20, quantity: 5)
      end

      it 'should equal 100' do
        expect(@lot_record.available).to eq(100)
      end
    end
  end

  describe '#total_cost_price' do
    context 'when not have any :instock_items' do
      it 'should equal 0' do
        lot_record = create :inventory_item_lot
        expect(lot_record.total_cost_price).to eq(0)
      end
    end

    context 'when have :instock_items but not specify :price_per_count' do
      it 'should equal 0' do
        lot_record = create :inventory_item_lot, instock_items: create_list(:inventory_item_lot_stock_in, 5, quantity: 10, price_per_count: nil)
        lot_record.instock_items << create_list(:inventory_item_lot_stock_in, 5, quantity: 10, price_per_count: 100)
        expect(lot_record.total_cost_price).to eq(500)
      end
    end
  end

  describe '#avg_cost' do
    before(:each) do
      @lot_record = create :inventory_item_lot
    end
    context 'when not have any :instock_items' do
      it 'should :avg_cost_price to equal 0' do
        expect(@lot_record.avg_cost_price).to eq(0)
      end
    end

    context 'when have :instock_items' do
      it 'should :avg_cost_price to equal 50' do
        @lot_record.instock_items << create_list(:inventory_item_lot_stock_in, 5, price_per_count: 50)
        expect(@lot_record.avg_cost_price).to eq(50)
      end

      it 'should :avg_cost_price to equal 50' do
        @lot_record.instock_items << create_list(:inventory_item_lot_stock_in, 5, price_per_count: 50)
        @lot_record.instock_items << create_list(:inventory_item_lot_stock_in, 5, price_per_count: 25)
        expect(@lot_record.avg_cost_price).to eq(37.5)
      end
    end
  end

  describe '#total_outstock' do
    context 'when not found any :outstock_items' do
      it 'should equal 0' do
        lot_record = create :inventory_item_lot
        expect(lot_record.total_outstock).to eq(0)
      end
    end

    context 'when found :outstock_items' do
      before(:each) do
        @lot_record = create :inventory_item_lot, outstock_items: create_list(:inventory_item_lot_stock_out, 20, quantity: 10)
      end
      it 'should have :outstock_items records' do
        expect(@lot_record.outstock_items.count).to eq(20)
      end

      it 'should equal 200' do
        expect(@lot_record.total_outstock).to eq(200)
      end
    end
  end

  describe '#total_instock' do
    context 'when not found any :instock_items' do
      it 'should equal 0' do
        lot_record = create :inventory_item_lot
        expect(lot_record.total_instock).to eq(0)
      end
    end

    context 'when found any :instock_items' do
      before(:each) do
        @lot_record = create :inventory_item_lot, instock_items: create_list(:inventory_item_lot_stock_in, 20, quantity: 10)
      end
      it 'should equal 200' do
        expect(@lot_record.total_instock).to eq(200)
      end

      it 'should have :instock_items records' do
        expect(@lot_record.instock_items.count).to eq(20)
      end
    end
  end

  describe 'Association' do
    describe '#inventory_item' do
      it { should belong_to(:inventory_item).class_name('Inventory::InventoryItem').with_foreign_key(:inventory_inventory_item_id) }
    end

    describe '#warehouse_facility' do
      it { should belong_to(:store_at).class_name('Warehouse::Facility').with_foreign_key(:warehouse_facility_id) }
    end

    describe '#instock_items' do
      it { should have_many(:instock_items).class_name('Inventory::ItemLotStockIn').with_foreign_key(:inventory_item_lot_id) }
    end

    describe '#outstock_items' do
      it { should have_many(:outstock_items).class_name('Inventory::ItemLotStockOut').with_foreign_key(:inventory_item_lot_id) }
    end
  end
end
